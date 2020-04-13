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
        return contents.last
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

extension Stack: Collection {
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

extension Stack: BidirectionalCollection {
    public var last: Element? {
        return contents.last
    }

    public func index(before i: Int) -> Int {
        return contents.index(before: i)
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
