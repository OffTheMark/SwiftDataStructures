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
    
    public mutating func push(_ element: Element) {
        contents.append(element)
    }
    
    public mutating func pop() -> Element? {
        return contents.popLast()
    }
    
    public mutating func removeAll() {
        contents.removeAll()
    }
    
    public var top: Element? {
        return contents.last
    }
    
    public var count: Int {
        return contents.count
    }
    
    public var isEmpty: Bool {
        return contents.isEmpty
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

// MARK: ExpressibleByArrayLiteral

extension Stack: ExpressibleByArrayLiteral {
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

// MARK: Equatable

extension Stack: Equatable where Element: Equatable {}
