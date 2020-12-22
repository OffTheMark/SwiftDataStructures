//
//  Deque.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: Deque

public struct Deque<Element> {
    private var contents = LinkedList<Element>()

    // MARK: Creating a Deque

    public init() {}

    public init<S: Sequence>(_ sequence: S) where Element == S.Element {
        for element in sequence {
            append(element)
        }
    }

    // MARK: Adding Elements

    public mutating func prepend(_ value: Element) {
        contents.prepend(value)
    }

    public mutating func append(_ value: Element) {
        contents.append(value)
    }
    
    public mutating func append<S: Sequence>(contentsOf newElements: S) where S.Element == Element {
        contents.append(contentsOf: newElements)
    }

    // MARK: Removing Elements

    @discardableResult public mutating func removeFirst() -> Element {
        return contents.removeFirst()
    }

    @discardableResult public mutating func removeLast() -> Element {
        return contents.removeLast()
    }

    public mutating func removeAll() {
        contents.removeAll()
    }

    // MARK: Moving Elements

    public mutating func rotateRight(by positions: Int = 1) {
        precondition(positions > 0, "Number of positions must be positive.")

        if isEmpty {
            return
        }

        let effectivePositions = positions % count

        if effectivePositions == 0 {
            return
        }

        for _ in 0 ..< effectivePositions {
            let removed = removeLast()
            prepend(removed)
        }
    }

    public mutating func rotateLeft(by positions: Int = 1) {
        precondition(positions > 0, "Number of positions must be positive.")

        if isEmpty {
            return
        }

        let effectivePositions = positions % count

        if effectivePositions == 0 {
            return
        }

        for _ in 0 ..< effectivePositions {
            let removed = removeFirst()
            append(removed)
        }
    }
}

// MARK: Sequence

extension Deque: Sequence {
    // MARK: Creating an Iterator

    public typealias Element = Element

    public __consuming func makeIterator() -> Iterator {
        return Iterator(contents.makeIterator())
    }
    
    public struct Iterator: IteratorProtocol {
        private var base: LinkedList<Element>.Iterator
        
        fileprivate init(_ base: LinkedList<Element>.Iterator) {
            self.base = base
        }
        
        public mutating func next() -> Element? {
            return base.next()
        }
    }
}

// MARK: Collection

extension Deque: Collection {
    public typealias Index = Int

    // MARK: Manipulating Indices

    public var startIndex: Int {
        return contents.startIndex
    }

    public var endIndex: Int {
        return contents.endIndex
    }

    public var indices: Range<Int> {
        return contents.indices
    }

    public func index(after i: Int) -> Int {
        return contents.index(after: i)
    }

    // MARK: Instance Properties

    public var count: Int {
        return contents.count
    }

    public var first: Element? {
        return contents.first
    }

    public var isEmpty: Bool {
        return contents.isEmpty
    }
}

// MARK: BidirectionalCollection

extension Deque: BidirectionalCollection {
    public var last: Element? {
        return contents.last
    }

    public func index(before i: Int) -> Int {
        return contents.index(before: i)
    }
}

// MARK: MutableCollection

extension Deque: MutableCollection {
    // MARK: Accessing a Collection's Elements

    public subscript(position: Int) -> Element {
        get {
            return contents[position]
        }
        set {
            contents[position] = newValue
        }
    }
}

// MARK: RangeReplaceableCollection

extension Deque: RangeReplaceableCollection {
    public mutating func replaceSubrange<S: Sequence>(_ subrange: Range<Index>, with newElements: __owned S) where Element == S.Element {
        contents.replaceSubrange(subrange, with: newElements)
    }
}

// MARK: RandomAccessCollection

extension Deque: RandomAccessCollection {}

// MARK: Hashable

extension Deque: Hashable where Element: Hashable {}

// MARK: Equatable

extension Deque: Equatable where Element: Equatable {}

// MARK: ExpressibleByArrayLiteral

extension Deque: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element

    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

// MARK: CustomStringConvertible

extension Deque: CustomStringConvertible {
    public var description: String {
        return "[" + lazy.map({ "\($0)" }).joined(separator: ", ") + "]"
    }
}
