//
//  Bag.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: Bag

public struct Bag<Item: Hashable> {
    // MARK: Properties

    private var contents: [Item: Int] = [:]

    // MARK: Creating a Bag

    public init() {}

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Item {
        for element in sequence {
            add(element)
        }
    }

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Item, value: Int) {
        for (element, count) in sequence {
            add(element, count: count)
        }
    }

    // MARK: Inspecting a Bag

    public var uniqueCount: Int {
        return contents.count
    }

    public func count(of element: Item) -> Int {
        return self[element, default: 0]
    }

    public subscript(item: Item) -> Int? {
        return contents[item]
    }

    public subscript(item: Item, default defaultValue: @autoclosure () -> Int) -> Int {
        return contents[item, default: defaultValue()]
    }

    // MARK: Adding Elements

    public mutating func add(_ item: Item, count: Int = 1) {
        precondition(count > 0, "Count must be positive.")

        contents[item, default: 0] += count
    }

    // MARK: Removing Elements

    /// Removes `count` of the given `item`.
    ///
    /// - Parameter item: Item to remove.
    /// - Parameter count: Number of the given item to remove.
    ///
    /// - Returns: The number of items that were actually removed, or `nil` if the bag did non contain the given `item`.
    ///
    /// If the bag contains
    @discardableResult public mutating func remove(_ item: Item, count: Int = 1) -> Element? {
        precondition(count > 0, "Count must be positive.")

        guard let currentCount = contents[item] else {
            return nil
        }

        if currentCount <= count, let removed = contents.removeValue(forKey: item) {
            return (item, removed)
        }

        contents[item] = currentCount - count
        return (item, count)
    }

    @discardableResult public mutating func removeAll(of item: Item) -> Element? {
        guard let removed = contents.removeValue(forKey: item) else {
            return nil
        }
        
        return (item, removed)
    }

    public mutating func removeAll() {
        contents.removeAll()
    }
}

// MARK: Sequence

extension Bag: Sequence {
    public typealias Element = (item: Item, count: Int)

    public __consuming func makeIterator() -> Iterator {
        return Iterator(contents.makeIterator())
    }
    
    public struct Iterator: IteratorProtocol {
        private var base: Dictionary<Item, Int>.Iterator
        
        fileprivate init(_ base: Dictionary<Item, Int>.Iterator) {
            self.base = base
        }
        
        public mutating func next() -> Element? {
            guard let next = base.next() else {
                return nil
            }
            
            return (next.key, next.value)
        }
    }
}

// MARK: Collection

extension Bag: Collection {
    public typealias Index = BagIndex<Item>

    // MARK: Manipulating Indices

    public var startIndex: Index {
        return BagIndex(contents.startIndex)
    }

    public var endIndex: Index {
        return BagIndex(contents.endIndex)
    }

    public func index(after i: Index) -> Index {
        return Index(contents.index(after: i.index))
    }

    // MARK: Instance Properties

    public var count: Int {
        return contents.values.reduce(0, { result, currentCount in
            return result + currentCount
        })
    }

    var first: Self.Element? {
        let dictionaryElement = contents.first

        return dictionaryElement.map({ key, value in
            return (key, value)
        })
    }

    public var isEmpty: Bool {
        return contents.isEmpty
    }

    // MARK: Accessing a Collection's Elements

    public subscript(position: Index) -> Self.Element {
        precondition(indices.contains(position), "Index is out of bounds")

        let dictionaryElement = contents[position.index]
        return (dictionaryElement.key, dictionaryElement.value)
    }
}

// MARK: CustomStringConvertible

extension Bag: CustomStringConvertible {
    public var description: String {
        return String(describing: contents)
    }
}

// MARK: ExpressibleByArrayLiteral

extension Bag: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Item...) {
        self.init(elements)
    }
}

// MARK: ExpressibleByDictionaryLiteral

extension Bag: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Item, Int)...) {
        let pairs = elements.map({ (key, value) in
            return (key: key, value: value)
        })
        self.init(pairs)
    }
}

// MARK: Equatable

extension Bag: Equatable where Item: Equatable {
    public static func == (lhs: Bag<Item>, rhs: Bag<Item>) -> Bool {
        return lhs.contents == rhs.contents
    }
}

// MARK: - BagIndex

public struct BagIndex<Element: Hashable> {
    fileprivate let index: DictionaryIndex<Element, Int>

    fileprivate init(_ dictionaryIndex: DictionaryIndex<Element, Int>) {
        self.index = dictionaryIndex
    }
}

// MARK: Comparable

extension BagIndex: Comparable {
    public static func == (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index == rhs.index
    }

    public static func <= (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index <= rhs.index
    }

    public static func >= (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index >= rhs.index
    }

    public static func < (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index < rhs.index
    }

    public static func > (lhs: BagIndex, rhs: BagIndex) -> Bool {
        return lhs.index > rhs.index
    }
}
