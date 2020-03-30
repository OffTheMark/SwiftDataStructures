//
//  OrderedDictionaryUpdateIndexTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-30.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class OrderedDictionaryUpdateIndexTests: XCTestCase {
    // MARK: Replacing Elements at Index in an OrderedDictionary
    
    func test_DictionaryWithElements_AfterReplacingElementAtIndexInMiddle_ContainsExpectedElements() {
        var dictionary: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        
        dictionary[1] = (key: "fourth", value: 3)
        
        XCTAssertEqual(dictionary, ["first": 0, "fourth": 3, "third": 2])
        XCTAssertEqual(dictionary.count, 3)
    }
    
    // MARK: Replacing Subranges in an OrderedDictionary
    
    func test_EmptyDictionary_AfterAppendingWithNewElements_ContainsNewElementsInCorrectOrder() {
        var dictionary = OrderedDictionary<String, Int>()
        
        dictionary.append(contentsOf: [(key: "first", value: 0), (key: "second", value: 1)])
        
        XCTAssertEqual(dictionary, ["first": 0, "second": 1])
        XCTAssertEqual(dictionary.count, 2)
    }

    func test_DictionaryWithElements_AfterPrepending_ContainsNewElementsFollowedByExistingElement() {
        var dictionary: OrderedDictionary = ["third": 2, "fourth": 3]
        
        dictionary.insert(contentsOf: [(key: "first", value: 0), (key: "second", value: 1)], at: 0)
        
        XCTAssertEqual(dictionary, ["first": 0, "second": 1, "third": 2, "fourth": 3])
        XCTAssertEqual(dictionary.count, 4)
    }
    
    func test_DictionaryWithElements_AfterInsertingNewElementsInMiddle_ContainsExpectedElements() {
        var dictionary: OrderedDictionary = ["first": 0, "second": 1, "fifth": 4]
        
        dictionary.insert(
            contentsOf:[(key: "third", value: 2), (key: "fourth", value: 3)],
            at: 2
        )
        
        XCTAssertEqual(dictionary, ["first": 0, "second": 1, "third": 2, "fourth": 3, "fifth": 4])
        XCTAssertEqual(dictionary.count, 5)
    }
    
    func test_DictionaryWithElements_AfterReplacingElementsAtIndicesWithNewElements_ContainsExpectedElements() {
        var dictionary: OrderedDictionary = ["first": 0, "second": 1, "third": 2, "fourth": 3]
        
        dictionary.replaceSubrange(
            1 ..< 3,
            with: [(key: "fifth", value: 4), (key: "sixth", value: 5)]
        )
        
        XCTAssertEqual(dictionary, ["first": 0, "fifth": 4, "sixth": 5, "fourth": 3])
        XCTAssertEqual(dictionary.count, 4)
    }

    func test_DictionaryWithElements_AfterReplacingIndicesWithNewElements_ContainsNewElements() {
        var dictionary: OrderedDictionary = ["first": 0]
        
        dictionary.replaceSubrange(
            dictionary.indices,
            with: [(key: "third", value: 2), (key: "fourth", value: 3)]
        )
        
        XCTAssertEqual(dictionary, ["third": 2, "fourth": 3])
        XCTAssertEqual(dictionary.count, 2)
    }

    func test_DictionaryWithOneElement_AfterAppendingNewElements_ContainsExistingElementFollowedByNewElements() {
        var dictionary: OrderedDictionary = ["first": 0, "second": 1]
        
        dictionary.append(contentsOf: [(key: "third", value: 2), (key: "fourth", value: 3)])
        
        XCTAssertEqual(dictionary, ["first": 0, "second": 1, "third": 2, "fourth": 3])
        XCTAssertEqual(dictionary.count, 4)
    }
}
