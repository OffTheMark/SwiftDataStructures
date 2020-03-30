//
//  OrderedDictionary.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: OrderedDictionary

///
/// An ordered collection whose elements are key-value pairs, where keys are ordered.
///
public struct OrderedDictionary<Key: Hashable, Value> {
    private var sortedKeys = Array<Key>()
    private var valuesByKey = Dictionary<Key, Value>()
    
    // MARK: Creating an OrderedDictionary
    
    public init() {}
    
    /// Creates an empty ordered dictionary with preallocated space for at least the specified number of elements.
    ///
    /// - Parameter minimumCapacity: The minimum number of key-value pairs that the newly created dictionary should be able to store without reallocating its storage buffer.
    init(minimumCapacity: Int) {
        self.init()
        self.reserveCapacity(minimumCapacity)
    }
    
    /// Creates a new ordered dictionary from the key-value pairs in the given sequence.
    ///
    /// - Parameter keysAndValues: A sequence of key-value pairs to use for the new dictionary. Every key in `keysAndValues` must be unique.
    ///
    /// - Returns: A new dictionary initialized with the elements of `keysAndValues`.
    init<S: Sequence>(uniqueKeysWithValues keysAndValues: S) where S.Element == (Key, Value) {
        if let orderedDictionary = keysAndValues as? OrderedDictionary<Key, Value> {
            self = orderedDictionary
            return
        }
        
        for (key, value) in keysAndValues {
            precondition(containsKey(key) == false, "Sequence of key-value pairs contains duplicate keys.")
            self[key] = value
        }
    }
    
    // MARK: Accessing Keys and Values
    
    /// Accesses the value associated with the given key for reading and writing.
    ///
    /// - Parameter key: The key to find in the dictionary.
    ///
    /// - Returns: The value associated with key if key is in the dictionary; otherwise, `nil`.
    public subscript(key: Key) -> Value? {
        get {
            return valuesByKey[key]
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            }
            else {
                removeValue(forKey: key)
            }
        }
        _modify {
            yield &self[key]
        }
    }
    
    /// Accesses the value associated with the given key. If the dictionary doesn't contain the given key, access the provided default value as if the key and default value existed in the dictionary.
    ///
    /// - Parameter key: The key to find in the dictionary.
    /// - Parameter defaultValue: The default value to use if `key` doesn't exist in the dictionary.
    ///
    /// - Returns: The value associated with key if key is in the dictionary; otherwise, `defaultValue`.
    public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        get {
            return self[key] ?? defaultValue()
        }
        set {
            updateValue(newValue, forKey: key)
        }
        _modify {
            if containsKey(key) == false {
                self[key] = defaultValue()
            }
            yield &self[key]!
        }
    }
    
    private func containsKey(_ key: Key) -> Bool {
        return valuesByKey[key] != nil
    }
    
    public var keys: Keys {
        return Keys(dictionary: self)
    }
    
    public var values: Values {
        return Values(dictionary: self)
    }
    
    // MARK: Adding Keys and Values
    
    /// Updates the valyes stored in the dictionary for the given key, or adds a new key-value pair if the key does not exist.
    ///
    /// - Parameters:
    ///   - value: The new value to add to the dictionary.
    ///   - key: If `key` already exists in the dictionary, `value` replaces the existing associated value. If `key` isn’t already a` key` of the dictionary, the (`key`, `value`) pair is appended to
    ///     the dictionary.
    ///
    /// - Returns: The value that was replaced, or `nil` if a new key-value pair was appended.
    @discardableResult
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        if let currentValue = valuesByKey[key] {
            valuesByKey[key] = value
            return currentValue
        }
        else {
            sortedKeys.append(key)
            valuesByKey[key] = value
            return nil
        }
    }
    
    public mutating func reserveCapacity(_ minimumCapacity: Int) {
        sortedKeys.reserveCapacity(minimumCapacity)
        valuesByKey.reserveCapacity(minimumCapacity)
    }
    
    // MARK: Removing Keys and Values
    
    /// Removes the given key and its associated value from the dictionary.
    ///
    /// - Parameter key: The key to remove along with its associated value.
    ///
    /// - Returns: The value that was removed, or `nil` if the key was not present in the dictionary.
    @discardableResult
    public mutating func removeValue(forKey key: Key) -> Value? {
        guard let indexOfKey = index(forKey: key) else {
            return nil
        }
        
        let currentValue = valuesByKey[key]
        
        sortedKeys.remove(at: indexOfKey)
        valuesByKey[key] = nil
        
        return currentValue
    }
    
    public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        sortedKeys.removeAll(keepingCapacity: keepCapacity)
        valuesByKey.removeAll(keepingCapacity: keepCapacity)
    }
    
    // MARK: Transforming a Dictionary
    
    /// Returns a new ordered dictionary contains the keys of this dictionary with the values transformed by the given closure.
    ///
    /// - Parameter transform: A closure that transforms a value. `transforms` accepts each value of the dictionary as its parameter and returns a transformed value of the same or of a
    /// different type.
    ///
    /// - Returns: A dictionary contains the keys and transformed values of this dictionary, with the keys preserving their order from this dictionary.
    ///
    /// Complexity: O(_n_), where _n_ is the length of the dictionary.
    public func mapValues<T>(_ transform: (Value) throws -> T) rethrows -> OrderedDictionary<Key, T> {
        let newElements: [(key: Key, value: T)] = try map({ key, value in
            let newValue = try transform(value)
            return (key, newValue)
        })
        
        return OrderedDictionary<Key, T>(uniqueKeysWithValues: newElements)
    }
    
    /// Returns a new ordered dictionary containing only the key-value pairs that have non-nil values as the result of transformation by the given closure.
    ///
    /// - Parameter transform: A closure that transforms a value. `transforms` accepts each value of the dictionary as its parameter and returns an optional transformed value of the same or of a
    /// different type.
    ///
    /// - Returns: A dictionary contains the keys and non-`nil` transformed values of this dictionary, with the keys preserving their order from this dictionary.
    ///
    /// Complexity: O(_n_), where _n_ is the length of the dictionary.
    public func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> OrderedDictionary<Key, T> {
        let newElements: [(key: Key, value: T)] = try compactMap({ key, value in
            guard let newValue = try transform(value) else {
                return nil
            }
            
            return (key, newValue)
        })
        
        return OrderedDictionary<Key, T>(uniqueKeysWithValues: newElements)
    }
    
    // MARK: - OrderedDictionary.Keys
    
    public struct Keys {
        fileprivate var dictionary: OrderedDictionary<Key, Value>
    }
    
    // MARK: - OrderedDictionary.Values
    
    public struct Values {
        fileprivate var dictionary: OrderedDictionary<Key, Value>
    }
}

// MARK: - OrderedDictionary

// MARK: Sequence

extension OrderedDictionary: Sequence {
    public typealias Element = (key: Key, value: Value)
    
    public __consuming func makeIterator() -> Iterator {
        return Iterator(keysIterator: sortedKeys.makeIterator(), valuesByKey: valuesByKey)
    }
    
    public struct Iterator: IteratorProtocol {
        fileprivate var keysIterator: Array<Key>.Iterator
        fileprivate let valuesByKey: Dictionary<Key, Value>
        
        public mutating func next() -> (key: Key, value: Value)? {
            guard let key = keysIterator.next(), let value = valuesByKey[key] else {
                return nil
            }
            
            return (key, value)
        }
    }
}

// MARK: Collection

extension OrderedDictionary: Collection {
    public typealias Index = Int
    public typealias Indidces = Range<Int>
    
    // MARK: Manipulating Indices
    
    public var startIndex: Int {
        return sortedKeys.startIndex
    }
    
    public var endIndex: Int {
        return sortedKeys.endIndex
    }
    
    public var indices: Range<Int> {
        return sortedKeys.indices
    }
    
    public func index(after i: Int) -> Int {
        return sortedKeys.index(after: i)
    }
    
    public func index(forKey key: Key) -> Int? {
        return sortedKeys.firstIndex(of: key)
    }
    
    // MARK: Instance Properties
    
    public var count: Int {
        return valuesByKey.count
    }
    
    public var isEmpty: Bool {
        return valuesByKey.isEmpty
    }
    
    // MARK: Accessing a Collection's Elements
    
    public subscript(position: Int) -> (key: Key, value: Value) {
        get {
            precondition(indices.contains(position), "Index out of range.")
            
            let key = sortedKeys[position]
            let value = valuesByKey[key]!
            
            return (key, value)
        }
        set(newElement) {
            precondition(indices.contains(position), "Index out of range.")
            
            replaceSubrange(position ..< position + 1, with: [newElement])
        }
        _modify {
            yield &self[position]
        }
    }
}

// MARK: BidirectionalCollection

extension OrderedDictionary: BidirectionalCollection {
    public func index(before i: Int) -> Int {
        return sortedKeys.index(before: i)
    }
}

// MARK: RangeReplaceableCollection

extension OrderedDictionary: RangeReplaceableCollection {
    public mutating func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: __owned C) where Element == C.Element {
        precondition(subrange.lowerBound >= startIndex, "Subrange bounds are out of range.")
        precondition(subrange.upperBound <= endIndex, "Subrange bounds are out of range.")
        
        for element in self[subrange] {
            removeValue(forKey: element.key)
        }
        
        var indexToInsert = subrange.startIndex
        for (key, value) in newElements {
            sortedKeys.insert(key, at: indexToInsert)
            valuesByKey[key] = value
            
            indexToInsert = sortedKeys.index(after: indexToInsert)
        }
    }
}

// MARK: MutableCollection

extension OrderedDictionary: MutableCollection {}

// MARK: Hashable

extension OrderedDictionary: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        var commutativeHash = 0
        
        for (key, value) in self {
            var elementHasher = hasher
            elementHasher.combine(key)
            elementHasher.combine(value)
            commutativeHash ^= elementHasher.finalize()
        }
        
        hasher.combine(commutativeHash)
    }
}

// MARK: Equatable

extension OrderedDictionary: Equatable where Value: Equatable {
    public static func == (lhs: OrderedDictionary<Key, Value>, rhs: OrderedDictionary<Key, Value>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        let elementPairs = zip(lhs, rhs)
        
        return elementPairs.allSatisfy({ leftElement, rightElement in
            return leftElement == rightElement
        })
    }
}

// MARK: CustomStringConvertible

extension OrderedDictionary: CustomStringConvertible {
    public var description: String {
        if isEmpty {
            return "[:]"
        }
        
        let keyValuesPairs: [String] = self.lazy.map({ (key, value) in
            let reflectionOfKey = String(reflecting: key)
            let reflectionOfValue = String(reflecting: value)
            
            return "\(reflectionOfKey): \(reflectionOfValue)"
        })
        let description = "[\(keyValuesPairs.joined(separator: ", "))]"
        
        return description
    }
}

// MARK: ExpressibleByDictionaryLiteral

extension OrderedDictionary: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(uniqueKeysWithValues: elements)
    }
}

// MARK: - OrderedDictionary.Keys

// MARK: Sequence

extension OrderedDictionary.Keys: Sequence {
    public typealias Element = Key
    
    public __consuming func makeIterator() -> Iterator {
        return Iterator(dictionary.makeIterator())
    }
    
    public struct Iterator: IteratorProtocol {
        fileprivate var base: OrderedDictionary<Key, Value>.Iterator
        
        fileprivate init(_ base: OrderedDictionary<Key, Value>.Iterator) {
            self.base = base
        }
        
        public mutating func next() -> Key? {
            guard let next = base.next() else {
                return nil
            }
            
            return next.key
        }
    }
}

// MARK: - OrderedDictionary.Values

// MARK: Sequence

extension OrderedDictionary.Values: Sequence {
    public typealias Element = Value
    
    public __consuming func makeIterator() -> Iterator {
        return Iterator(dictionary.makeIterator())
    }
    
    public struct Iterator: IteratorProtocol {
        fileprivate var base: OrderedDictionary<Key, Value>.Iterator
        
        fileprivate init(_ base: OrderedDictionary<Key, Value>.Iterator) {
            self.base = base
        }
        
        public mutating func next() -> Value? {
            guard let next = base.next() else {
                return nil
            }
            
            return next.value
        }
    }
}
