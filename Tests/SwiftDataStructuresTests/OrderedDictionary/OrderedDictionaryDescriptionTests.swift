//
//  OrderedDictionaryDescriptionTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest
@testable import SwiftDataStructures

final class OrderedDictionaryDescriptionTests: XCTestCase {

    func test_EmptyDictionary_WhenGettingDescription_ReturnsEmptyDescription() {
        // Given
        let elements = OrderedDictionary<String, Int>()
        let expectedDescription = "[:]"
        
        // When
        let description = elements.description
        
        // Then
        XCTAssertEqual(description, expectedDescription)
    }
    
    func test_DictionaryWithElements_WhenGettingDescription_ReturnsDescriptionWithKeyValuePairsInCorrectOrder() {
        // Given
        let elements: OrderedDictionary = ["banana": 1, "apple": 3, "strawberry": 6]
        let expectedDescription = "[\(String(reflecting: "banana")): 1, \(String(reflecting: "apple")): 3, \(String(reflecting: "strawberry")): 6]"
        
        // When
        let description = elements.description
        
        // Then
        XCTAssertEqual(description, expectedDescription)
    }
}
