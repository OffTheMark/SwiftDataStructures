//
//  SortExtensions.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: Sequence

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
