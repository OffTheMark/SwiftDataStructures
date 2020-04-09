//
//  OrderedDictionaryIterateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-09.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class OrderedDictionaryIterateTests: XCTestCase {
    // MARK: Iterating Over an Ardered Dictionary
    
    func test_EmptyDictionary_WhenIteratingOverElements_ReturnsNoElements() {
        let elements = OrderedDictionary<String, Int>()
        var iterator = elements.makeIterator()
        
        XCTAssertNil(iterator.next())
    }
    
    func test_DictionaryWithElements_WhenIteratingOverElements_ReturnsElementsInExpectedOrder() {
        let elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        var iterator = elements.makeIterator()
        
        let first = iterator.next()
        let second = iterator.next()
        let third = iterator.next()
        let elementPastEnd = iterator.next()
        
        XCTAssertEqual(first?.key, "first")
        XCTAssertEqual(first?.value, 0)
        XCTAssertEqual(second?.key, "second")
        XCTAssertEqual(second?.value, 1)
        XCTAssertEqual(third?.key, "third")
        XCTAssertEqual(third?.value, 2)
        XCTAssertNil(elementPastEnd)
    }
    
    // MARK: Iterating Over an Ardered Dictionary's Keys
    
    func test_EmptyDictionary_WhenIteratingOverKeys_ReturnsNoKeys() {
        let elements = OrderedDictionary<String, Int>()
        let keys = elements.keys
        var iterator = keys.makeIterator()
        
        XCTAssertNil(iterator.next())
    }
    
    func test_DictionaryWithElements_WhenIteratingOverKeys_ReturnsKeysInExpectedOrder() {
        let elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        let keys = elements.keys
        var iterator = keys.makeIterator()
        
        let firstKey = iterator.next()
        let secondKey = iterator.next()
        let thirdKey = iterator.next()
        let keyPastEnd = iterator.next()
        
        XCTAssertEqual(firstKey, "first")
        XCTAssertEqual(secondKey, "second")
        XCTAssertEqual(thirdKey, "third")
        XCTAssertNil(keyPastEnd)
    }
    
    // MARK: Iterating Over an Ardered Dictionary's Values
    
    func test_EmptyDictionary_WhenIteratingOverValues_ReturnsNoValues() {
        let elements = OrderedDictionary<String, Int>()
        let values = elements.values
        var iterator = values.makeIterator()
        
        XCTAssertNil(iterator.next())
    }
    
    func test_DictionaryWithElements_WhenIteratingOverValues_ReturnsValuesInExpectedOrder() {
        let elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        let values = elements.values
        var iterator = values.makeIterator()
        
        let firstValue = iterator.next()
        let secondValue = iterator.next()
        let thirdValue = iterator.next()
        let valuePastEnd = iterator.next()
        
        XCTAssertEqual(firstValue, 0)
        XCTAssertEqual(secondValue, 1)
        XCTAssertEqual(thirdValue, 2)
        XCTAssertNil(valuePastEnd)
    }
}
