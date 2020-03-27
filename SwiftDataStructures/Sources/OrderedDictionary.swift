//
//  OrderedDictionary.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: OrderedDictionary

public struct OrderedDictionary<Key: Hashable, Value> {
    private var sortedKeys = Array<Key>()
    private var valuesByKey = Dictionary<Key, Value>()
    
    // MARK: Creating an OrderedDictionary
    
    public init() {}
    
    init(minimumCapacity: Int) {
        self.init()
        self.reserveCapacity(minimumCapacity)
    }
    
    init<S: Sequence>(uniqueKeysWithValues keysAndValues: S) where S.Element == (Key, Value) {
        if let orderedDictionary = keysAndValues as? OrderedDictionary<Key, Value> {
            self = orderedDictionary
            return
        }
        
        for (key, value) in keysAndValues {
            self[key] = value
        }
    }
    
    // MARK: Accessing Keys and Values
    
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
    }
    
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
    
    public func containsKey(_ key: Key) -> Bool {
        return valuesByKey[key] != nil
    }
    
    public var keys: Keys {
        return Keys(dictionary: self)
    }
    
    public var values: Values {
        return Values(dictionary: self)
    }
    
    // MARK: Adding Keys and Values
    
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
    
    // MARK: Manipulating Indices
    
    public var startIndex: Int {
        return sortedKeys.startIndex
    }
    
    public var endIndex: Int {
        return sortedKeys.endIndex
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
        precondition(indices.contains(position), "Index out of range.")
        
        let key = sortedKeys[position]
        let value = valuesByKey[key]!
        
        return (key, value)
    }
}

// MARK: BidirectionalCollection

extension OrderedDictionary: BidirectionalCollection {
    public func index(before i: Int) -> Int {
        return sortedKeys.index(before: i)
    }
}

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
