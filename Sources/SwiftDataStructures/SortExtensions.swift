//
//  SortExtensions.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: SortOrder

///
/// Order in which to compare elements.
///
public enum SortOrder {
    /// Ascending order.
    case ascending
    
    /// Descending order
    case descending
    
    /// Returns the comparison predicate used to compare two values of type `T`.
    public func makeComparator<T: Comparable>() -> (T, T) -> Bool {
        switch self {
        case .ascending:
            return (<)
            
        case .descending:
            return (>)
        }
    }
    
    /// Returns the comparison predicate used to compare two optional values of type `T?`.
    func makeComparator<T: Comparable>() -> (T?, T?) -> Bool {
        let valueComparator: (T, T) -> Bool = makeComparator()
        
        return { first, second in
            switch (first, second) {
            case (.some(let first), .some(let second)):
                return valueComparator(first, second)
                
            case (.some, .none):
                return self == .ascending
                
            case (.none, .some):
                return self == .descending
                
            case (.none, .none):
                return false
            }
        }
    }
}

// MARK: - SortCriterion

///
/// Criterion allowing to compare elements of a sequence or collection more easily.
///
public struct SortCriterion<Element> {
    // MARK: Properties
    
    /// Predicate that returns `true` if its first argument should be ordered before its second argument; otherwise, `false`.
    public let areInIncreasingOrder: (Element, Element) -> Bool
    
    /// Predicate that returns `true` if its first argument is equal to its second argument.
    public let areInEqualOrder: (Element, Element) -> Bool
    
    // MARK: Create a SortCriterion
    
    /// Creates a new criterion using the given predicates.
    ///
    /// - Parameters:
    ///   - areInIncreasingOrder: Predicate that returns `true` if its first argument should be ordered before its second argument; otherwise, `false`.
    ///   - areInEqualOrder: Predicate that returns `true` if its first argument is equal to its second argument.
    ///
    /// The predicate indicating if arguments are in increasing order must be a _strict weak ordering_ over the elements. That is, for any elements `a`, `b`, and `c`, the following conditions must hold:
    /// - `areInIncreasingOrder(a, a)` is always `false`. (Irreflexivity)
    /// - If `areInIncreasingOrder(a, b)` and `areInIncreasingOrder(b, c)` are both `true`, then `areInIncreasingOrder(a, c)` is also `true`. (Transitive comparability)
    /// - Two elements are incomparable if neither is ordered before the other according to the predicate. If `a` and `b` are incomparable, and `b` and `c` are incomparable, then `a` and `c` are also
    /// incomparable. (Transitive incomparability)
    public init(
        areInIncreasingOrder: @escaping (Element, Element) -> Bool,
        areInEqualOrder: @escaping (Element, Element) -> Bool
    ) {
        self.areInIncreasingOrder = areInIncreasingOrder
        self.areInEqualOrder = areInEqualOrder
    }
    
    /// Creates a new criterion using the value represented by the given key path and order as the comparison between elements.
    /// - Parameters:
    ///   - keyPath: Represents the value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    public init<Value: Comparable>(
        keyPath: KeyPath<Element, Value>,
        order: SortOrder = .ascending
    ) {
        let valueComparator: (Value, Value) -> Bool = order.makeComparator()
        let areInIncreasingOrder: (Element, Element) -> Bool = { first, second in
            return valueComparator(first[keyPath: keyPath], second[keyPath: keyPath])
        }
        let areInEqualOrder: (Element, Element) -> Bool = { first, second in
            return first[keyPath: keyPath] == second[keyPath: keyPath]
        }
        
        self.init(areInIncreasingOrder: areInIncreasingOrder, areInEqualOrder: areInEqualOrder)
    }
    
    /// Creates a new criterion using the optional value represented by the given key path and order as the comparison between elements.
    /// - Parameters:
    ///   - keyPath: Represents the optional value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    public init<Value: Comparable>(
        keyPath: KeyPath<Element, Value?>,
        order: SortOrder = .ascending
    ) {
        let valueComparator: (Value?, Value?) -> Bool = order.makeComparator()
        let areInIncreasingOrder: (Element, Element) -> Bool = { first, second in
            return valueComparator(first[keyPath: keyPath], second[keyPath: keyPath])
        }
        let areInEqualOrder: (Element, Element) -> Bool = { first, second in
            return first[keyPath: keyPath] == second[keyPath: keyPath]
        }
        
        self.init(areInIncreasingOrder: areInIncreasingOrder, areInEqualOrder: areInEqualOrder)
    }
}

// MARK: - Sequence

extension Sequence {
    // MARK: Reordering a Sequence's Elements
    
    /// Returns the elements of the sequence, sorted using the value represented by the given key path and the given order as comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    ///
    /// - Returns: A sorted array of the sequence’s elements.
    ///
    /// In this first example, we sort a sequence of `String` values in ascending order of their `count`.
    /// ```
    /// let names = ["Adam", "John", "Eve", "Michael"]
    /// let sorted = names.sorted(by: \.count, order: .ascending)
    /// print(sorted)
    /// // Prints "["Eve", "Adam", "John", "Michael"]"
    /// ```
    ///
    /// In this second example, we sort the elements of this same sequence in descending order of their `count`.
    /// ```
    /// let names = ["Adam", "John", "Eve", "Michael"]
    /// let sorted = names.sorted(by: \.count, order: .descending)
    /// print(sorted)
    /// // Prints "["Michael", "Adam", "John", "Eve"]"
    /// ```
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        order: SortOrder = .ascending
    ) -> [Element] {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.sorted(by: criterion.areInIncreasingOrder)
    }
    
    /// Returns the elements of the sequence, sorted using the optional value represented by the given key path and the given order as comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the optional value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    ///
    /// - Returns: A sorted array of the sequence’s elements.
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value?>,
        order: SortOrder = .ascending
    ) -> [Element] {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.sorted(by: criterion.areInIncreasingOrder)
    }
    
    /// Returns the elements of the sequence, sorted using the given criteria as the comparison between elements.
    ///
    /// - Parameter criteria: Criteria used to compare elements of the sequence.
    ///
    /// - Returns: A sorted array of the sequence’s elements.
    func sorted(by criteria: [SortCriterion<Element>]) -> [Element] {
        let areInIncreasingOrder: (Element, Element) -> Bool = { first, second in
            for criterion in criteria {
                if criterion.areInEqualOrder(first, second) {
                    continue
                }
                
                return criterion.areInIncreasingOrder(first, second)
            }
            
            return false
        }
        
        return self.sorted(by: areInIncreasingOrder)
    }
    
    // MARK: Finding Elements
    
    /// Returns the minimum element in the sequence, using the value represented by the given key path and the given order as comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    ///
    /// - Returns: The sequence’s minimum element, according to `keyPath`and `order`. If the sequence has no elements, returns `nil`.
    func min<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        order: SortOrder = .ascending
    ) -> Element? {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.min(by: criterion.areInIncreasingOrder)
    }
    
    /// Returns the minimum element in the sequence, using the optional value represented by the given key path and the given order as comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the optional value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    ///
    /// - Returns: The sequence’s minimum element, according to `keyPath`and `order`. If the sequence has no elements, returns `nil`.
    func min<Value: Comparable>(
        by keyPath: KeyPath<Element, Value?>,
        order: SortOrder = .ascending
    ) -> Element? {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.min(by: criterion.areInIncreasingOrder)
    }
    
    /// Returns the minimum element in the sequence, using the given criteria as comparison between elements.
    ///
    /// - Parameter criteria: Criteria used to compare elements of the sequence.
    ///
    /// - Returns: The sequence’s minimum element, according to `criteria`. If the sequence has no elements, returns `nil`.
    func min(by criteria: [SortCriterion<Element>]) -> Element? {
        let areInIncreasingOrder: (Element, Element) -> Bool = { first, second in
            for criterion in criteria {
                if criterion.areInEqualOrder(first, second) {
                    continue
                }
                
                return criterion.areInIncreasingOrder(first, second)
            }
            
            return false
        }
        
        return self.min(by: areInIncreasingOrder)
    }
    
    /// Returns the maximum element in the sequence, using the value represented by the given key path and the given order as comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    ///
    /// - Returns: The sequence’s maximum element, according to `keyPath`and `order`. If the sequence has no elements, returns `nil`.
    func max<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        order: SortOrder = .ascending
    ) -> Element? {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.max(by: criterion.areInIncreasingOrder)
    }
    
    /// Returns the maximum element in the sequence, using the optional value represented by the given key path and the given order as comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the optional value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    ///
    /// - Returns: The sequence’s maximum element, according to `keyPath`and `order`. If the sequence has no elements, returns `nil`.
    func max<Value: Comparable>(
        by keyPath: KeyPath<Element, Value?>,
        order: SortOrder = .ascending
    ) -> Element? {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.max(by: criterion.areInIncreasingOrder)
    }
    
    /// Returns the maximum element in the sequence, using the given criteria as comparison between elements.
    ///
    /// - Parameter criteria: Criteria used to compare elements of the sequence.
    ///
    /// - Returns: The sequence’s maximum element, according to `criteria`. If the sequence has no elements, returns `nil`.
    func max(by criteria: [SortCriterion<Element>]) -> Element? {
        let areInIncreasingOrder: (Element, Element) -> Bool = { first, second in
            for criterion in criteria {
                if criterion.areInEqualOrder(first, second) {
                    continue
                }
                
                return criterion.areInIncreasingOrder(first, second)
            }
            
            return false
        }
        
        return self.max(by: areInIncreasingOrder)
    }
}

// MARK: - MutableCollection

extension MutableCollection where Self: RandomAccessCollection {
    // MARK: Reordering a Collection's Elements
    
    /// Sorts the collection in place, using the value represented by the given key path and order as the comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    mutating func sort<Value: Comparable>(by keyPath: KeyPath<Element, Value>, order: SortOrder = .ascending) {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        self.sort(by: criterion.areInIncreasingOrder)
    }
    
    /// Sorts the collection in place, using the optional value represented by the given key path and order as the comparison between elements.
    ///
    /// - Parameters:
    ///   - keyPath: Represents the optional value used to compare elements of the sequence.
    ///   - order: Order used to compare elements of the sequence.
    mutating func sort<Value: Comparable>(by keyPath: KeyPath<Element, Value?>, order: SortOrder = .ascending) {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        self.sort(by: criterion.areInIncreasingOrder)
    }
    
    /// Sorts the collection in place, using the given criteria as the comparison between elements.
    ///
    /// - Parameter criteria: Criteria used to compare elements of the sequence.
    mutating func sort(by criteria: [SortCriterion<Element>]) {
        let areInIncreasingOrder: (Element, Element) -> Bool = { first, second in
            for criterion in criteria {
                if criterion.areInEqualOrder(first, second) {
                    continue
                }
                
                return criterion.areInIncreasingOrder(first, second)
            }
            
            return false
        }
        
        self.sort(by: areInIncreasingOrder)
    }
}
