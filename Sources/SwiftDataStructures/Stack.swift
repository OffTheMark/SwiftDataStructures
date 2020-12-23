//
//  Stack.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-04-13.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: Stack

public struct Stack<Element> {
    private var contents = LinkedList<Element>()
    
    // MARK: Creating a Stack
    
    public init() {}
    
    public init<S: Sequence>(_ sequence: S) where Element == S.Element {
        for element in sequence {
            push(element)
        }
    }
    
    // MARK: Accessing Elements
    
    public func peek() -> Element? {
        return last
    }
    
    // MARK: Adding Elements
    
    public mutating func push(_ element: Element) {
        contents.append(element)
    }
    
    // MARK: Removing Elements
    
    @discardableResult
    public mutating func pop() -> Element {
        return contents.removeLast()
    }
    
    public mutating func removeAll() {
        contents.removeAll()
    }
}

// MARK: Sequence

extension Stack: Sequence {
    public typealias Element = Element
    
    public __consuming func makeIterator() -> Iterator {
        let base = contents.makeIterator()
        return Iterator(base)
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

extension Stack: Collection {
    // MARK: Accessing a Collection's Elements
    
    public subscript(position: Index) -> Element {
        return contents[position.base]
    }
    
    // MARK: Manipulating Indices
    
    public var startIndex: Index {
        Index(contents.startIndex)
    }

    public var endIndex: Index {
        Index(contents.endIndex)
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

extension Stack: BidirectionalCollection {
    public var last: Element? {
        return contents.last
    }

    public func index(before i: Index) -> Index {
        let base = contents.index(before: i.base)
        return Index(base)
    }
}

// MARK: Equatable

extension Stack: Equatable where Element: Equatable {
    public static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool {
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

extension Stack: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element

    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

// MARK: CustomStringConvertible

extension Stack: CustomStringConvertible {
    public var description: String {
        return String(describing: contents)
    }
}

// MARK: - Stack.Index

// MARK: Comparable

extension Stack.Index: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.base < rhs.base
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.base == rhs.base
    }
}
