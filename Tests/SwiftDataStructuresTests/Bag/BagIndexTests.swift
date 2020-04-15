//
//  BagIndexTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest
@testable import SwiftDataStructures

final class BagIndexTests: XCTestCase {
    // MARK: Getting a Bag's Indices
    
    func test_EmptyBag_WhenGettingIndices_ReturnsEmptyIndices() {
        // Given
        let elements = Bag<String>()
        
        // When
        let indices = elements.indices
        let firstIndex = elements.startIndex
        let endIndex = elements.endIndex
        
        // Then
        XCTAssertTrue(indices.isEmpty)
        XCTAssertEqual(firstIndex, endIndex)
    }
    
    func test_BagWithElements_WhenGettingLastIndex_ReturnsCorrectIndex() {
        // Given
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        
        var currentIndex = elements.startIndex
        for _ in 0 ..< elements.count {
            currentIndex = elements.index(after: currentIndex)
        }
        
        XCTAssertEqual(currentIndex, elements.endIndex)
    }
    
    // MARK: Getting Elements from a Bag Using an Index
    
    func test_BagWithElements_WhenGettingElementByFirstIndexMatchingPredicate_ReturnsCorrectElement() throws {
        // Given
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        
        // When
        let indexOfBanana = try require(elements.firstIndex(where: { $0.item == "banana" }))
        let elementAtIndex = elements[indexOfBanana]
        
        XCTAssertEqual(elementAtIndex.item, "banana")
        XCTAssertEqual(elementAtIndex.count, 1)
    }
    
    // MARK: Getting Elements from a Bag Using an Index
    
    func test_BagWithElements_WhenGettingElementByIndexFromItem_ReturnsCorrectElement() throws {
        // Given
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        
        // When
        let indexOfOrange = try require(elements.index(forItem: "orange"))
        let elementAtIndex = elements[indexOfOrange]
        
        XCTAssertEqual(elementAtIndex.item, "orange")
        XCTAssertEqual(elementAtIndex.count, 5)
    }
}