//
//  SortExtensions.swift
//  SwiftDataStructures
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: SortOrder

public enum SortOrder {
    case ascending
    case descending
    
    public func makeComparator<T: Comparable>() -> (T, T) -> Bool {
        switch self {
        case .ascending:
            return (<)
            
        case .descending:
            return (>)
        }
    }
    
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

public struct SortCriterion<Element> {
    public let areInIncreasingOrder: (Element, Element) -> Bool
    
    public let areInEqualOrder: (Element, Element) -> Bool
    
    public init(
        areInIncreasingOrder: @escaping (Element, Element) -> Bool,
        areInEqualOrder: @escaping (Element, Element) -> Bool
    ) {
        self.areInIncreasingOrder = areInIncreasingOrder
        self.areInEqualOrder = areInEqualOrder
    }
    
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
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        order: SortOrder = .ascending
    ) -> [Element] {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.sorted(by: [criterion])
    }
    
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value?>,
        order: SortOrder = .ascending
    ) -> [Element] {
        let criterion = SortCriterion(keyPath: keyPath, order: order)
        return self.sorted(by: [criterion])
    }
    
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
}
