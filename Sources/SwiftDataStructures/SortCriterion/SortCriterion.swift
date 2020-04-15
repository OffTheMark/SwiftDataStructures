//
//  SortCriterion.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
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
/// Criterion allowing to indicate if two elements of the same type are in increasing order and in equal order.
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
