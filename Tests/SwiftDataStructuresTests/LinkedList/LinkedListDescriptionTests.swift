//
//  LinkedListDescriptionTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest
@testable import SwiftDataStructures

final class LinkedListDescriptionTests: XCTestCase {
    // MARK: Getting the Description of a LinkedList
    
    func test_EmptyList_WhenGettingDescription_ReturnsEmptyDescription() {
        let elements = LinkedList<String>()
        let expectedDescription = "[]"
        
        let description = elements.description
        
        XCTAssertEqual(description, expectedDescription)
    }
    
    func test_ListWithElements_WhenGettingDescription_ReturnsEmptyDescription() {
        let elements: LinkedList = ["banana", "apple", "orange"]
        let expectedDescription = "[\(String(reflecting: "banana")), \(String(reflecting: "apple")), \(String(reflecting: "orange"))]"
        
        let description = elements.description
        
        XCTAssertEqual(description, expectedDescription)
    }
}
