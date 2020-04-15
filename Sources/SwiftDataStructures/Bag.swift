//
//  Bag.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: Bag

///
/// A collection whose elements are item-count pairs.
///
/// A bag is a type of hash table, providing fast access to the entries it contains. Each entry in the table is identified using its item, which is a hashable type such as a string or number. You use that item to
/// retrieve the corresponding count, which is an integer.
///
public struct Bag<Item: Hashable> {
    // MARK: Properties

    private var contents = Dictionary<Item, Int>()

    // MARK: Creating a Bag

    /// Creates an empty bag.
    public init() {}
    
    /// Creates an empty bag with preallocated space for at least the specified number of elements.
    ///
    /// - Parameter minimumCapacity: The minimum number of item-count pairs that the newly created bag should be able to store without reallocating its storage buffer.
    ///
    /// Use this initializer to avoid intermediate reallocations of a bag's storage buffer when you know how many item-count pairs you are adding to a bag after creation.
    public init(minimumCapacity: Int) {
        self.init()
        self.reserveCapacity(minimumCapacity)
    }
    
    /// Creates a new bag from the items in the given sequence.
    ///
    /// - Parameter sequence: A sequence of items to use for the new bag.
    ///
    /// - Returns: A new bag initialized with the elements of `sequence`.
    public init<S: Sequence>(_ sequence: S) where S.Element == Item {
        for element in sequence {
            add(element)
        }
    }
    
    /// Creates a new bag from the item-count pairs in the given sequence.
    ///
    /// - Parameter itemsAndCounts: A sequence of item-count pairs to use for the new bag. Every item in `itemsAndCounts` must be unique.
    ///
    /// - Returns: A new bag initialized with the elements of `itemsAndCounts`.
    public init<S: Sequence>(uniqueItemsWithCounts itemsAndCounts: S) where S.Iterator.Element == (key: Item, value: Int) {
        if let bag = itemsAndCounts as? Bag<Item> {
            self = bag
            return
        }
        
        for (item, count) in itemsAndCounts {
            precondition(containsItem(item) == false, "Sequence of item-count pairs contains duplicate items.")
            add(item, count: count)
        }
    }

    // MARK: Inspecting a Bag
    
    public var totalCount: Int {
        return contents.values.reduce(into: 0, { result, count in
            result += count
        })
    }
    
    /// Returns the count associated with the given item.
    ///
    /// - Parameter item: The item to find in the bag.
    ///
    /// - Returns: The count associated with the item if the item is in the bag; otherwise 0.
    public func count(of item: Item) -> Int {
        return contents[item, default: 0]
    }
    
    /// The total number of item-count pairs that the bag can contain without allocating new storage.
    public var capacity: Int {
        return contents.capacity
    }
    
    /// Returns a Boolean value indicating if the bag contains at least one of the given item.
    ///
    /// - Parameter item: The item to find in the bag.
    public func containsItem(_ item: Item) -> Bool {
        return contents[item] != nil
    }
    
    /// A collection containing just the items of the bag.
    public var items: Items {
        return Items(bag: self)
    }

    /// Access the count associated with the given item.
    ///
    /// - Parameter item: The item to find in the bag.
    ///
    /// - Returns: The count associated with the item if the item is in the bag; otherwise 0.
    public subscript(item: Item) -> Int {
        get {
            return count(of: item)
        }
        set {
            updateCount(newValue, ofItem: item)
        }
        _modify {
            if containsItem(item) == false {
                contents[item] = 0
            }
            
            yield &contents[item]!
        }
    }

    // MARK: Adding Elements
    
    /// Adds a number of `item`s to the bag equal to `count`.
    ///
    /// - Parameters:
    ///   - item: The item to add to the bag.
    ///   - count: The count to associate with `item`. `count` must be greather than 0.
    ///
    /// - Postcondition:
    ///     - If `item` already exists in the bag, the count is simply the sum of the previous count for the given item and `count`.
    ///     - If `item` does not exist in the bag, a new item-count pair is added.
    public mutating func add(_ item: Item, count: Int = 1) {
        precondition(count > 0, "Count must be greater than 0.")

        self[item] += count
    }

    // MARK: Removing Elements

    /// Removes `count` of the given `item`.
    ///
    /// - Parameter item: The item to remove.
    /// - Parameter count: The associated count of item to remove. `count` must be greater than 0.
    ///
    /// - Returns: The item and the number of items that were actually removed if the bag did contain the given item; otherwise `nil`.
    ///
    /// - Postcondition:
    ///     - If the bag contained more of the given item than `count`, the count of the given item becomes the subtraction of the previous count for that item and `count`
    ///     - If the bag contained as many or less of the given item than `count`, all of the given item are removed.
    ///     - If the bag did not contain the given item, the bag is unchanged.
    @discardableResult
    public mutating func remove(_ item: Item, count: Int = 1) -> Element? {
        precondition(count > 0, "Count must be positive.")

        guard containsItem(item) else {
            return nil
        }
        
        let currentCount = self.count(of: item)
        if count >= currentCount {
            contents.removeValue(forKey: item)
            return (item, currentCount)
        }
        
        contents.updateValue(currentCount - count, forKey: item)
        return (item, count)
    }
    
    /// Removes the given item and its associated count from the bag.
    ///
    /// - Parameter item: The item to remove along with its count.
    ///
    /// - Returns: The number of this item that the bag contained if the bag did contain the given item; otherwise `nil`.
    @discardableResult
    public mutating func removeAll(of item: Item) -> Element? {
        guard let removed = contents.removeValue(forKey: item) else {
            return nil
        }
        
        return (item, removed)
    }
    
    /// Updates the count stored in the bag for the given item, or adds a new item-count pair if the bag does not contain the item.
    ///
    /// - Parameters:
    ///   - count: The count of the given item to add to the bag.
    ///   - item: The item to associate with `count`.
    ///
    /// - Returns: The count of the given item that were replaced, or `nil` if the item didn't already exist in the dictionary.
    ///
    /// - Postcondition:
    ///     - If `item` already exists in the bag, `count` replaces the previous count.
    ///     - If `item` doesn't already exist in the dictionary, the (`item`, `count`) pair is added.
    ///     - If `item` already exists in the bag and `count` is equal to `0`, all of the given item are removed from the bag.
    @discardableResult
    public mutating func updateCount(_ count: Int, ofItem item: Item) -> Int? {
        precondition(count >= 0, "Count must be greater than or equal to 0.")
        
        if count == 0 {
            return contents.removeValue(forKey: item)
        }
        
        return contents.updateValue(count, forKey: item)
    }
    
    /// Removes all items from the bag.
    ///
    /// - Parameter keepCapacity: Whether the bag should keep its underlying buffer. If you pass true, the operation preserves the buffer capacity that the collection has, otherwise the underlying buffer is released. The default is false.
    ///
    /// Calling this method invalidates all indices with respect to the dictionary.
    ///
    /// Complexity: O(_n_), where _n_ is the number of item-count pairs in the bag.
    public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        contents.removeAll(keepingCapacity: keepCapacity)
    }
    
    /// Reserves enough space to store the specified number of item-count pairs.
    ///
    /// - Parameter minimumCapacity: The requested number of item-count pairs to store.
    ///
    /// If you are adding a known number of item-count pairs to a bag, use this method to avoid multiple reallocations. This method ensures that the bag has unique, mutable, contiguous storage, with space
    /// allocated for at least the requested number of item-count pairs.
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        contents.reserveCapacity(minimumCapacity)
    }
    
    // MARK: - Items
    
    ///
    /// A view of a bag's items.
    ///
    public struct Items {
        fileprivate var bag: Bag<Item>
    }
}

// MARK: - Bag

// MARK: Sequence

extension Bag: Sequence {
    public typealias Element = (item: Item, count: Int)

    public __consuming func makeIterator() -> Iterator {
        let base = contents.makeIterator()
        return Iterator(base)
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
        let dictionaryElement = contents.first

        return dictionaryElement.map({ key, value in
            return (key, value)
        })
    }

    public var isEmpty: Bool {
        return contents.isEmpty
    }
    
    public func index(forItem item: Item) -> Index? {
        guard let base = contents.index(forKey: item) else {
            return nil
        }
        
        return Index(base)
    }

    // MARK: Accessing a Collection's Elements

    public subscript(position: Index) -> Element {
        precondition(indices.contains(position), "Index is out of bounds")

        let dictionaryElement = contents[position.base]
        return (dictionaryElement.key, dictionaryElement.value)
    }
    
    // MARK: - Index
    
    public struct Index {
        fileprivate let base: Dictionary<Item, Int>.Index

        fileprivate init(_ dictionaryIndex: Dictionary<Item, Int>.Index) {
            self.base = dictionaryIndex
        }
    }
}

// MARK: - Bag

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
        
        self.init(uniqueItemsWithCounts: pairs)
    }
}

// MARK: Equatable

extension Bag: Equatable where Item: Equatable {
    public static func == (lhs: Bag<Item>, rhs: Bag<Item>) -> Bool {
        return lhs.contents == rhs.contents
    }
}

// MARK: - Bag.Items

extension Bag.Items: Sequence {
    public typealias Element = Item
    
    public __consuming func makeIterator() -> Bag<Item>.Items.Iterator {
        return Iterator(bag.makeIterator())
    }
    
    public struct Iterator: IteratorProtocol {
        fileprivate var base: Bag<Item>.Iterator
        
        fileprivate init(_ base: Bag<Item>.Iterator) {
            self.base = base
        }
        
        public mutating func next() -> Item? {
            guard let next = base.next() else {
                return nil
            }
            
            return next.item
        }
    }
}

// MARK: - Bag.Index

// MARK: Equatable

extension Bag.Index: Hashable {}

// MARK: Comparable

extension Bag.Index: Comparable {
    public static func <= (lhs: Bag.Index, rhs: Bag.Index) -> Bool {
        return lhs.base <= rhs.base
    }

    public static func >= (lhs: Bag.Index, rhs: Bag.Index) -> Bool {
        return lhs.base >= rhs.base
    }

    public static func < (lhs: Bag.Index, rhs: Bag.Index) -> Bool {
        return lhs.base < rhs.base
    }

    public static func > (lhs: Bag.Index, rhs: Bag.Index) -> Bool {
        return lhs.base > rhs.base
    }
}
