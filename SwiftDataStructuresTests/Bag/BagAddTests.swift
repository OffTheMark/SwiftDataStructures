//
//  BagAddTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class BagAddTests: XCTestCase {
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
}
