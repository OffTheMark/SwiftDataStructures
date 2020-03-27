//
//  OrderedDictionaryDecodableJSONTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class OrderedDictionaryDecodableJSONTests: XCTestCase {
    // MARK: Propriétés
    
    private var decoder: JSONDecoder!
    
    override func setUp() {
        super.setUp()
        
        decoder = JSONDecoder()
    }
    
    override func tearDown() {
        decoder = nil
        
        super.tearDown()
    }
    
    // MARK: Decode an OrderedDictionary - Valid data
    
    func test_DataForEmptyDictionary_AfterDecoding_ReturnsEmptyDictionary() throws {
        // Given
        let data = Data("{}".utf8)
        let expected = OrderedDictionary<String, Int>()
        
        // When
        let decoded = try decoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        // Then
        XCTAssertEqual(decoded, expected)
    }
    
    func test_DataWithDictionaryWithMoreThanOneElement_AfterDecoding_ReturnsDictionaryWithKeyValuePairsInCorrectOrder() throws {
        // Given
        let data = Data("""
        {
            "first": 0,
            "second": 1,
            "third": 2
        }
        """.utf8)
        
        // When
        let decoded = try decoder.decode(OrderedDictionary<String, Int>.self, from: data)
        
        // Then
        XCTAssertEqual(decoded.count, 3)
        XCTAssertEqual(decoded["first"], 0)
        XCTAssertEqual(decoded["second"], 1)
        XCTAssertEqual(decoded["third"], 2)
    }
}
