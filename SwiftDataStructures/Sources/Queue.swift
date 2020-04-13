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
    public typealias Index = Int
    
    // MARK: Accessing a Collection's Elements
    
    public subscript(position: Int) -> Element {
        return contents[position]
    }
    
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

extension Queue: BidirectionalCollection {
    public var last: Element? {
        return contents.last
    }

    public func index(before i: Int) -> Int {
        return contents.index(before: i)
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
