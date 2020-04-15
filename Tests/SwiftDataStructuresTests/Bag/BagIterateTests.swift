//
//  BagIterateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest
@testable import SwiftDataStructures

final class BagIterateTests: XCTestCase {
    // MARK: Iterating Over a Bag's Elements
    
    func test_EmptyBag_WhenIteratingOverElements_ReturnsNoElements() {
        let elements = Bag<String>()
        var iterator = elements.makeIterator()
        
        XCTAssertNil(iterator.next())
    }
    
    func test_BagWithElements_WhenIteratingOverElements_ReturnsAllElements() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5]
        var iterator = elements.makeIterator()
        var results = [ItemCountPair<String>]()
        let expectedResults: [ItemCountPair<String>] = [
            .init(item: "banana", count: 1),
            .init(item: "apple", count: 3),
            .init(item: "orange", count: 5)
        ]
        
        while let next = iterator.next() {
            let pair = ItemCountPair(item: next.item, count: next.count)
            results.append(pair)
        }
        
        assertThat(results, containsSameUnsortedElementsAs: expectedResults)
    }
    
    // MARK: Iterating Over a Bag's Items
    
    func test_EmptyBag_WhenIteratingOverItems_ReturnsNoItems() {
        let elements = Bag<String>()
        let items = elements.items
        var iterator = items.makeIterator()
        
        XCTAssertNil(iterator.next())
    }
    
    func test_BagWithElements_WhenIteratingOverItems_ReturnsAllItems() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5]
        let items = elements.items
        var iterator = items.makeIterator()
        var results = [String]()
        let expectedResults: [String] = ["banana", "apple", "orange"]
        
        while let next = iterator.next() {
            results.append(next)
        }
        
        assertThat(results, containsSameUnsortedElementsAs: expectedResults)
    }
    
    // MARK: - ItemCountPair
    
    struct ItemCountPair<Item: Hashable>: Equatable {
        let item: Item
        let count: Int
    }
}
