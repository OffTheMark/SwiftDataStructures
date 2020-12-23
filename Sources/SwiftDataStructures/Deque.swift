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
    // MARK: Manipulating Indices

    public var startIndex: Index {
        let base = contents.startIndex
        return Index(base)
    }

    public var endIndex: Index {
        let base = contents.endIndex
        return Index(base)
    }

    public func index(after i: Index) -> Index {
        let base = contents.index(after: i.base)
        return Index(base)
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
    public struct Index {
        fileprivate let base: LinkedList<Element>.Index
        
        fileprivate init(_ base: LinkedList<Element>.Index) {
            self.base = base
        }
    }
}

// MARK: BidirectionalCollection

extension Deque: BidirectionalCollection {
    public var last: Element? {
        return contents.last
    }

    public func index(before i: Index) -> Index {
        let base = contents.index(before: i.base)
        return Index(base)
    }
}

// MARK: MutableCollection

extension Deque: MutableCollection {
    // MARK: Accessing a Collection's Elements

    public subscript(position: Index) -> Element {
        get {
            return contents[position.base]
        }
        set {
            contents[position.base] = newValue
        }
    }
}

// MARK: RangeReplaceableCollection

extension Deque: RangeReplaceableCollection {
    public mutating func replaceSubrange<S: Sequence>(_ subrange: Range<Index>, with newElements: __owned S) where Element == S.Element {
        let baseSubrange = subrange.lowerBound.base ..< subrange.upperBound.base
        contents.replaceSubrange(baseSubrange, with: newElements)
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

// MARK: - Deque.Index

// MARK: Comparable

extension Deque.Index: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.base < rhs.base
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.base == rhs.base
    }
}
