//
//  StackIndexTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest
@testable import SwiftDataStructures

final class StackIndexTests: XCTestCase {
    // MARK: Getting a Stack's Indices
    
    func test_EmptyStack_WhenGettingIndices_ReturnsEmptyIndices() {
        // Given
        let elements = Stack<String>()
        
        // When
        let indices = elements.indices
        
        // Then
        XCTAssertTrue(indices.isEmpty)
    }
    
    func test_EmptyStack_WhenGettingFirstAndLastIndex_ReturnsSameIndex() {
        // Given
        let elements = Stack<String>()
        
        // When
        let startIndex = elements.startIndex
        let endIndex = elements.endIndex
        
        // Then
        XCTAssertEqual(startIndex, endIndex)
    }
    
    func test_StackWithElements_WhenGettingFirstIndex_ReturnsCorrectIndex() {
        // Given
        let elements: Stack = ["banana", "apple", "orange", "strawberry"]
        
        // When
        var currentIndex = elements.endIndex
        for _ in 0 ..< elements.count {
            currentIndex = elements.index(before: currentIndex)
        }
        
        // Then
        XCTAssertEqual(currentIndex, elements.startIndex)
    }
    
    func test_StackWithElements_WhenGettingLastIndex_ReturnsCorrectIndex() {
        // Given
        let elements: Stack = ["banana", "apple", "orange", "strawberry"]
        
        // When
        var currentIndex = elements.startIndex
        for _ in 0 ..< elements.count {
            currentIndex = elements.index(after: currentIndex)
        }
        
        // Then
        XCTAssertEqual(currentIndex, elements.endIndex)
    }
}
