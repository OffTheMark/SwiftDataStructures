//
//  BagUpdateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class BagUpdateTests: XCTestCase {
    // MARK: Adding Elements to an Empty Bag

    func test_EmptyBag_AfterAddingItem_ContainsOneOfItem() {
        // Given
        var bag = Bag<String>()

        // When
        bag.add("item")

        // Then
        XCTAssertEqual(bag, ["item": 1])
    }

    func test_EmptyBag_AfterAddingMultiplesOfItem_ContainsCorrectNumberOfItem() {
        // Given
        var bag = Bag<String>()

        // When
        bag.add("item", count: 5)

        // Then
        XCTAssertEqual(bag, ["item": 5])
    }
    
    // MARK: Adding Elements to a Non-Empty Bag

    func test_BagWithMultipleOfItemAndOthers_AfterAddingItem_ContainsCorrectCountOfAddedItemAndSameCountOfOthers() {
        // Given
        var bag: Bag = ["item": 2, "otherItem": 1]

        // When
        bag.add("item")

        // Then
        XCTAssertEqual(bag, ["item": 3, "otherItem": 1])
    }

    func test_BagWithMultiplesOfItemAndOthers_AfterAddingMultiplesOfItem_ContainsCorrectCountOfAddedItemAndSameCountOfOthers() {
        // Given
        var bag: Bag = ["item": 2, "otherItem": 1]

        // When
        bag.add("item", count: 3)
        
        // Then
        XCTAssertEqual(bag, ["item": 5, "otherItem": 1])
    }
    
    // MARK: Removing Elements in an Empty Bag
    
    func test_EmptyBag_AfterRemovingOneOfitem_IsEmpty() {
        var bag = Bag<String>()

        bag.remove("item")

        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }
    
    func test_EmptyBag_AfterRemovingOneOfItem_ReturnsNilRemovedElements() {
        var bag = Bag<String>()
        
        let removed = bag.remove("item")
        
        XCTAssertNil(removed)
    }
    
    func test_EmptyBag_AfterRemovingAllOfItem_IsEmpty() {
        var bag = Bag<String>()

        bag.removeAll(of: "item")

        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }
    
    func test_EmptyBag_AfterRemovingAlOfItem_ReturnsNilRemovedElements() {
        var bag = Bag<String>()

        let removed = bag.removeAll(of: "item")

        XCTAssertNil(removed)
    }
    
    // MARK: Removing Elements in a Bag

    func test_EmptyBag_AfterRemovingAll_IsEmpty() {
        var bag = Bag<String>()

        bag.removeAll()
        
        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }
    
    func test_BagWithOneOfAnItem_AfterRemovingOneOfItem_IsEmpty() {
        var bag: Bag = ["item"]

        bag.remove("item")

        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }
    
    func test_BagWithOneOfAnItem_AfterRemovingOneOfItem_ReturnsCorrectRemovedElements() {
        var bag: Bag = ["item"]

        let removed = bag.remove("item")

        XCTAssertEqual(removed?.item, "item")
        XCTAssertEqual(removed?.count, 1)
    }
    
    func test_BagWithOneOfAnItem_AfterRemovingAll_IsEmpty() {
        var bag: Bag = ["item"]
        
        bag.removeAll()
        
        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }

    func test_BagWithMultiplesOfAnItem_AfterRemovingLessThanCountOfItem_ContainsCorrectNumberOfItems() {
        var bag: Bag = ["item": 5]

        bag.remove("item", count: 2)

        XCTAssertEqual(bag.count, 1)
        XCTAssertEqual(bag, ["item": 3])
    }

    func test_BagWithMultiplesOfAnItem_AfterRemovingLessThanCountOfItem_ReturnsCorrectRemovedElements() {
        var bag: Bag = ["item": 5]

        let removed = bag.remove("item", count: 2)

        XCTAssertEqual(removed?.item, "item")
        XCTAssertEqual(removed?.count, 2)
    }

    func test_BagWithMultiplesOfAnItem_AfterRemovingSameNumberOfItem_IsEmpty() {
        var bag: Bag = ["item": 2]

        bag.remove("item", count: 2)
        
        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }
    
    func test_BagWithMultiplesOfAnItem_AfterRemovingSameNumberOfItem_ReturnsCorrectRemovedElement() {
        var bag: Bag = ["item": 2]

        let removed = bag.remove("item", count: 2)
        
        XCTAssertEqual(removed?.item, "item")
        XCTAssertEqual(removed?.count, 2)
    }
    
    func test_BagWithMultiplesOfAnItem_AfterRemovingMoreItemsThanAreContained_IsEmpty() {
        var bag: Bag = ["item": 2]

        bag.remove("item", count: 10)
        
        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }
    
    func test_BagWithMultiplesOfAnItem_AfterRemovingMoreItemsThanAreContained_ReturnsCorrectRemovedElement() {
        var bag: Bag = ["item": 2]

        let removed = bag.remove("item", count: 10)
        
        XCTAssertEqual(removed?.item, "item")
        XCTAssertEqual(
            removed?.count,
            2,
            "The count of removed elements is the number of items that are actually removed from the bag, which is not necessarily the given number of items to remove."
        )
    }

    func test_BagWithMultiplesOfAnItem_AfterRemovingAllOfItem_IsEmpty() {
        var bag: Bag = ["item": 2]

        bag.removeAll(of: "item")
        
        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }

    func test_BagWithMultiplesOfAnItem_AfterRemovingAllOfItem_ReturnsCorrectRemovedElement() {
        var bag: Bag = ["item": 2]

        let removed = bag.removeAll(of: "item")
        
        XCTAssertEqual(removed?.item, "item")
        XCTAssertEqual(removed?.count, 2)
    }
    
    func test_BagWithMultipleItems_AfterRemovingAll_IsEmpty() {
        var bag: Bag = ["item": 2, "otherItem": 3]
        
        bag.removeAll()
        
        XCTAssertTrue(bag.isEmpty)
        XCTAssertEqual(bag, [:])
    }
}
