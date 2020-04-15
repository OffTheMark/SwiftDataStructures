//
//  DequeIndexTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest
@testable import SwiftDataStructures

final class DequeIndexTests: XCTestCase {
    // MARK: Getting a Deque's Indices
    
    func test_EmptyDeque_WhenGettingIndices_ReturnsEmptyIndices() {
        // Given
        let elements = Deque<String>()
        
        // When
        let indices = elements.indices
        
        // Then
        XCTAssertTrue(indices.isEmpty)
    }
    
    func test_EmptyDeque_WhenGettingFirstAndLastIndex_ReturnsSameIndex() {
        // Given
        let elements = Deque<String>()
        
        // When
        let startIndex = elements.startIndex
        let endIndex = elements.endIndex
        
        // Then
        XCTAssertEqual(startIndex, 0)
        XCTAssertEqual(endIndex, 0)
    }
    
    func test_DequeWithElements_WhenGettingFirstIndex_ReturnsCorrectIndex() {
        // Given
        let elements: Deque = ["banana", "apple", "orange", "strawberry"]
        
        // When
        var currentIndex = elements.endIndex
        for _ in 0 ..< elements.count {
            currentIndex = elements.index(before: currentIndex)
        }
        
        // Then
        XCTAssertEqual(currentIndex, elements.startIndex)
    }
    
    func test_DequeWithElements_WhenGettingLastIndex_ReturnsCorrectIndex() {
        // Given
        let elements: Deque = ["banana", "apple", "orange", "strawberry"]
        
        // When
        var currentIndex = elements.startIndex
        for _ in 0 ..< elements.count {
            currentIndex = elements.index(after: currentIndex)
        }
        
        // Then
        XCTAssertEqual(currentIndex, elements.endIndex)
    }
    
    func test_DequeWithElements_WhenGettingIndices_ReturnsExpectedIndices() {
        // Given
        let elements: Deque = ["banana", "apple", "orange", "strawberry"]
        let expectedIndices = 0 ..< 4
        
        // When
        let indices = elements.indices
        
        // Then
        XCTAssertEqual(indices, expectedIndices)
        XCTAssertEqual(indices, elements.startIndex ..< elements.endIndex)
    }
}
