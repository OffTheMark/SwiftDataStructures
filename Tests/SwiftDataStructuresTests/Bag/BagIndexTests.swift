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
        let startIndex = elements.startIndex
        let endIndex = elements.endIndex
        
        // Then
        XCTAssertTrue(indices.isEmpty)
        XCTAssertEqual(startIndex, endIndex)
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
    
    // MARK: Comparing Indices of a Bag
    
    func test_StartIndexOfBagWithElements_WhenCheckingIfIsLessThanFollowingIndex_ReturnsTrue() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        
        XCTAssertTrue(elements.startIndex < elements.index(after: elements.startIndex))
    }
    
    func test_StartIndexOfBagWithElements_WhenCheckingIfIsLessThanOrEqualToFollowingIndex_ReturnsTrue() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        
        XCTAssertTrue(elements.startIndex <= elements.index(after: elements.startIndex))
    }
    
    func test_StartIndexOfBagWithElements_WhenCheckingIfIsGreaterThanFollowingIndex_ReturnsFalse() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        
        XCTAssertFalse(elements.startIndex > elements.index(after: elements.startIndex))
    }
    
    func test_StartIndexOfBagWithElements_WhenCheckingIfIsGreaterThanOrEqualToFollowingIndex_ReturnsFalse() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        
        XCTAssertFalse(elements.startIndex >= elements.index(after: elements.startIndex))
    }
    
    func test_IndexOfBagWithElements_WhenCheckingIfIsLessThanPreviousIndexReturnsFalse() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        let index = elements.index(after: elements.startIndex)
        
        XCTAssertFalse(index < elements.startIndex)
    }
    
    func test_IndexOfBagWithElements_WhenCheckingIfIsLessThanOrEqualToPreviousIndex_ReturnsFalse() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        let index = elements.index(after: elements.startIndex)
        
        XCTAssertFalse(index <= elements.startIndex)
    }
    
    func test_IndexOfBagWithElements_WhenCheckingIfIsGreaterThanPreviousIndex_ReturnsTrue() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        let index = elements.index(after: elements.startIndex)
        
        XCTAssertTrue(index > elements.startIndex)
    }
    
    func test_IndexOfBagWithElements_WhenCheckingIfIsGreaterThanOrEqualToPreviousIndex_ReturnsTrue() {
        let elements: Bag = ["banana": 1, "apple": 3, "orange": 5, "strawberry": 6]
        let index = elements.index(after: elements.startIndex)
        
        XCTAssertTrue(index >= elements.startIndex)
    }
}
