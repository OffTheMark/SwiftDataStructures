//
//  Queue.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: Queue

public struct Queue<Element> {
    private var contents = LinkedList<Element>()
    
    // MARK: Creating a Queue
    
    public init() {}
    
    public init<S: Sequence>(_ sequence: S) where Element == S.Element {
        for element in sequence {
            enqueue(element)
        }
    }
    
    // MARK: Accessing Elements
    
    public func peek() -> Element? {
        return contents.first
    }
    
    // MARK: Adding Elements
    
    public mutating func enqueue(_ value: Element) {
        contents.append(value)
    }
    
    // MARK: Removing Elements
    
    @discardableResult
    public mutating func dequeue() -> Element {
        return contents.removeFirst()
    }
    
    public mutating func removeAll() {
        contents.removeAll()
    }
}

// MARK: Sequence

extension Queue: Sequence {
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

extension Queue: Collection {
    // MARK: Accessing a Collection's Elements
    
    public subscript(position: Index) -> Element {
        contents[position.base]
    }
    
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

extension Queue: BidirectionalCollection {
    public var last: Element? {
        return contents.last
    }

    public func index(before i: Index) -> Index {
        let base = contents.index(before: i.base)
        return Index(base)
    }
}

// MARK: Equatable

extension Queue: Equatable where Element: Equatable {
    public static func == (lhs: Queue<Element>, rhs: Queue<Element>) -> Bool {
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

extension Queue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element

    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

// MARK: CustomStringConvertible

extension Queue: CustomStringConvertible {
    public var description: String {
        return String(describing: contents)
    }
}

// MARK: - Queue.Index

// MARK: Comparable

extension Queue.Index: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.base < rhs.base
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.base == rhs.base
    }
}
