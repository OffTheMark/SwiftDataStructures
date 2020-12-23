//
//  LinkedList.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: LinkedList

public struct LinkedList<Element> {
    private var head: Node? = nil
    private var tail: Node? = nil
    public private(set) var count = 0
    
    private var identifier = Identifier()
    
    fileprivate class Identifier {
        init() {}
    }

    // MARK: Creating a LinkedList

    public init() {}

    public init<S: Sequence>(_ sequence: S) where Element == S.Element {
        let chain = NodeChain(sequence)
        
        self.head = chain.head
        self.tail = chain.tail
        self.count = chain.count
    }

    // MARK: Adding Elements

    public mutating func prepend(_ value: Element) {
        replaceSubrange(startIndex..<startIndex, with: [value])
    }
    
    public mutating func prepend<S: Sequence>(contentsOf sequence: S) where S.Element == Element {
        replaceSubrange(startIndex..<startIndex, with: sequence)
    }

    // MARK: Private Methods
    
    private mutating func copyNodes(settingNodeAt index: Index, to value: Element) {
        identifier = Identifier()
        
        var currentIndex = startIndex
        var currentNode = Node(value: currentIndex.node!.value)
        if index == currentIndex {
            currentNode.value = value
        }
        let newHead = currentNode
        currentIndex = self.index(after: currentIndex)
        
        while currentIndex < endIndex {
            let nextNode = Node(value: currentIndex.node!.value)
            if currentIndex == index {
                nextNode.value = value
            }
            
            currentNode.next = nextNode
            nextNode.previous = currentNode
            currentNode = nextNode
            currentIndex = self.index(after: currentIndex)
        }
        
        head = newHead
        tail = currentNode
    }
    
    @discardableResult
    private mutating func copyNodes(removingRange range: Range<Index>) -> Range<Index> {
        identifier = Identifier()
        
        var currentIndex = startIndex
        
        while range.contains(currentIndex) {
            currentIndex = index(after: currentIndex)
        }
        
        guard let headValue = currentIndex.node?.value else {
            self = .init()
            return endIndex ..< endIndex
        }
        
        var currentNode = Node(value: headValue)
        let newHead = currentNode
        var newCount = 1
        
        var removedRange: Range<Index> = Index(node: currentNode, offset: 0, listIdentifier: identifier) ..< Index(node: currentNode, offset: 0, listIdentifier: identifier)
        currentIndex = index(after: currentIndex)
        
        while currentIndex < endIndex {
            if range.contains(currentIndex) {
                currentIndex = index(after: currentIndex)
                continue
            }
            
            let nextNode = Node(value: currentIndex.node!.value)
            if currentIndex == range.upperBound {
                removedRange = Index(node: nextNode, offset: newCount, listIdentifier: identifier) ..< Index(node: nextNode, offset: newCount, listIdentifier: identifier)
            }
            
            currentNode.next = nextNode
            nextNode.previous = currentNode
            currentNode = nextNode
            newCount += 1
            currentIndex = index(after: currentIndex)
        }
        
        if currentIndex == range.upperBound {
            removedRange = Index(node: nil, offset: newCount, listIdentifier: identifier) ..< Index(node: nil, offset: newCount, listIdentifier: identifier)
        }
        
        head = newHead
        tail = currentNode
        count = newCount
        
        return removedRange
    }

    // MARK: - LinkedList.Node

    fileprivate class Node {
        public var value: Element
        public var next: Node? = nil
        public weak var previous: Node? = nil

        public init(value: Element) {
            self.value = value
        }
    }
}

// MARK: - LinkedList

// MARK: Sequence

extension LinkedList: Sequence {
    // MARK: Creating an Iterator

    public typealias Element = Element

    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: head)
    }

    public struct Iterator: IteratorProtocol {
        private var currentNode: Node?

        fileprivate init(node: Node?) {
            currentNode = node
        }

        public mutating func next() -> Element? {
            guard let currentNode = currentNode else {
                return nil
            }

            self.currentNode = currentNode.next
            return currentNode.value
        }
    }
}

// MARK: Collection

extension LinkedList: Collection {
    // MARK: Manipulating Indices

    public var startIndex: Index {
        Index(node: head, offset: 0, listIdentifier: identifier)
    }

    public var endIndex: Index {
        Index(node: nil, offset: count, listIdentifier: identifier)
    }

    public func index(after i: Index) -> Index {
        precondition(i.listIdentifier === identifier, "LinkedList index is invalid.")
        precondition(i.offset < endIndex.offset, "LinkedList index is out of bounds.")
        
        return Index(node: i.node?.next, offset: i.offset + 1, listIdentifier: identifier)
    }

    // MARK: Instance Properties

    /// The first element of the collection.
    public var first: Element? {
        return head?.value
    }

    public var isEmpty: Bool {
        return count == 0
    }
    
    public struct Index {
        fileprivate weak var node: Node?
        fileprivate var offset: Int
        fileprivate weak var listIdentifier: Identifier?
        
        fileprivate init(node: Node?, offset: Int, listIdentifier: Identifier) {
            self.node = node
            self.offset = offset
            self.listIdentifier = listIdentifier
        }
    }
}

extension LinkedList.Index: Comparable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.offset == rhs.offset
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.offset < rhs.offset
    }
}

// MARK: BidirectionalCollection

extension LinkedList: BidirectionalCollection {
    /// The last element of the collection.
    ///
    /// - complexity: O(1)
    public var last: Element? {
        return tail?.value
    }

    public func index(before i: Index) -> Index {
        precondition(i.listIdentifier === identifier, "Index is invalid.")
        precondition(i.offset > startIndex.offset, "Index is out of range.")
        
        if i.offset == count {
            return Index(node: tail, offset: i.offset - 1, listIdentifier: identifier)
        }
        
        return Index(node: i.node?.previous, offset: i.offset - 1, listIdentifier: identifier)
    }
}

// MARK: MutableCollection

extension LinkedList: MutableCollection {
    // MARK: Accessing a Collection's Elements

    public subscript(position: Index) -> Element {
        get {
            precondition(position.listIdentifier === identifier, "Index is invalid.")
            precondition((0 ..< count).contains(position.offset), "Index is out of range.")
            
            guard let node = position.node else {
                preconditionFailure("LinkedList index is invalid.")
            }
            
            return node.value
        }
        set {
            precondition(position.listIdentifier === identifier, "Index is invalid.")
            precondition((0 ..< count).contains(position.offset), "Index is out of range.")
            
            if !isKnownUniquelyReferenced(&head) {
                copyNodes(settingNodeAt: position, to: newValue)
            }
            else {
                position.node?.value = newValue
            }
        }
    }
}

// MARK: RangeReplaceableCollection

extension LinkedList: RangeReplaceableCollection {
    public mutating func replaceSubrange<S: Sequence>(_ subrange: Range<Index>, with newElements: __owned S) where Element == S.Element {
        var subrange = subrange.relative(to: indices)
        
        precondition(subrange.lowerBound.listIdentifier === identifier && subrange.upperBound.listIdentifier === identifier, "Range of indices is invalid.")
        precondition(subrange.lowerBound >= startIndex, "Subrange bounds are out of range.")
        precondition(subrange.upperBound <= endIndex, "Subrange bounds are out of range.")
        
        let chain = NodeChain(newElements)
        
        if chain.isEmpty {
            removeElements(at: subrange)
            return
        }
        
        if subrange.lowerBound == startIndex, subrange.upperBound == endIndex {
            head = chain.head
            tail = chain.tail
            count = chain.count
            return
        }
        
        if !isKnownUniquelyReferenced(&head) {
            subrange = copyNodes(removingRange: subrange)
        }
        
        defer {
            count += chain.count - (subrange.upperBound.offset - subrange.lowerBound.offset)
        }
        
        if subrange.upperBound == startIndex {
            head?.previous = chain.tail
            chain.tail?.next = head
            head = chain.head
            return
        }
        
        if subrange.lowerBound == endIndex {
            tail?.next = chain.head
            chain.head?.previous = tail
            tail = chain.tail
            return
        }
        
        if subrange.lowerBound == startIndex {
            let nodeAfterTail = subrange.upperBound.node!
            nodeAfterTail.previous = chain.tail
            head = chain.head
            return
        }
        
        if subrange.upperBound == endIndex {
            let nodeBeforeHead = subrange.lowerBound.node!.previous!
            nodeBeforeHead.next = chain.head
            tail = chain.tail
            return
        }
        
        let nodeAtHead = subrange.lowerBound.node!
        let nodeAfterTail = subrange.upperBound.node!
        
        chain.head?.previous = nodeAtHead.previous
        nodeAtHead.previous?.next = chain.head
        
        nodeAfterTail.previous = chain.tail
        chain.tail?.next = nodeAfterTail
    }
    
    private mutating func removeElements(at range: Range<Index>) {
        if range.isEmpty {
            return
        }
        
        if range.lowerBound == startIndex, range.upperBound == endIndex {
            head = nil
            tail = nil
            count = 0
            return
        }
        
        guard isKnownUniquelyReferenced(&head) else {
            copyNodes(removingRange: range)
            return
        }
        
        defer {
            count -= range.upperBound.offset - range.lowerBound.offset
        }
        
        if range.lowerBound == startIndex {
            head = range.upperBound.node!
            head?.previous = nil
            return
        }
        
        if range.upperBound == endIndex {
            tail = range.lowerBound.node!.previous
            tail?.next = nil
            return
        }
        
        let nodeBeforeLowerBound: Node = range.lowerBound.node!.previous!
        
        range.upperBound.node!.previous = nodeBeforeLowerBound
        nodeBeforeLowerBound.next = range.upperBound.node!
    }
    
    fileprivate struct NodeChain {
        let head: Node?
        let tail: Node?
        var count = 0
        
        var isEmpty: Bool {
            return count == 0
        }
        
        init<S: Sequence>(_ sequence: S) where Element == S.Element {
            var iterator = sequence.makeIterator()
            
            guard let firstValue = iterator.next() else {
                head = nil
                tail = nil
                return
            }
            
            var currentNode = Node(value: firstValue)
            head = currentNode
            count += 1
            
            while let nextValue = iterator.next() {
                let nextNode = Node(value: nextValue)
                currentNode.next = nextNode
                nextNode.previous = currentNode
                currentNode = nextNode
                count += 1
            }
            
            tail = currentNode
        }
    }
}

// MARK: RandomAccessCollection

extension LinkedList: RandomAccessCollection {}

// MARK: Hashable

extension LinkedList: Hashable where Element: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(count)
        
        for value in self {
            hasher.combine(value)
        }
    }
}

// MARK: Equatable

extension LinkedList: Equatable where Element: Equatable {
    public static func == (lhs: LinkedList<Element>, rhs: LinkedList<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }

        let elementPairs = zip(lhs, rhs)

        return elementPairs.allSatisfy({ left, right in
            return left == right
        })
    }
}

// MARK: ExpressibleByArrayLiteral

extension LinkedList: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element

    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

// MARK: CustomStringConvertible

extension LinkedList: CustomStringConvertible {
    public var description: String {
        let descriptionsOfElements = self.map({ String(reflecting: $0) })
        return "[" +  descriptionsOfElements.joined(separator: ", ") + "]"
    }
}
