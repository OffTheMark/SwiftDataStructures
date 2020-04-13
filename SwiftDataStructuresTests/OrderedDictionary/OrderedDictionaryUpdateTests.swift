//
//  OrderedDictionaryUpdateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class OrderedDictionaryUpdateTests: XCTestCase {
    // MARK: Adding Elements in an Ordered Dictionary
    
    func test_EmptyDictionary_AfterAddingElementForKey_ContainsOnlyValueForKey() {
        var elements = OrderedDictionary<String, Int>()
        XCTAssertTrue(elements.isEmpty)
        
        elements["first"] = 0
        
        XCTAssertEqual(elements.count, 1)
        XCTAssertEqual(elements["first"], 0)
        XCTAssertEqual(elements, ["first": 0])
    }
    
    func test_EmptyDictionary_AfterSubscriptingElementWithDefaultForNewKey_CallsDefaultValueAndContainsOnlyValueForKey() {
        var elements = OrderedDictionary<String, Int>()
        XCTAssertTrue(elements.isEmpty)
        
        elements["first", default: 1] += 2
        
        XCTAssertEqual(elements.count, 1)
        XCTAssertEqual(elements["first"], 3)
        XCTAssertEqual(elements, ["first": 3])
    }
    
    func test_DictionaryWithOneElement_AfterAddingElementForNewKey_ContainsExistingElementFollowedByNewElement() {
        var elements: OrderedDictionary = ["first": 0]
        
        elements["second"] = 1
        
        XCTAssertEqual(elements.count, 2)
        XCTAssertEqual(elements["first"], 0)
        XCTAssertEqual(elements["second"], 1)
        XCTAssertEqual(elements, ["first": 0, "second": 1])
    }
    
    func test_DictionaryWithOneElement_AfterSubscriptingElementWithDefaultForNewKey_CallsDefaultValueAndContainsExistingElementFollowedByNewElement() {
        var elements: OrderedDictionary = ["first": 0]
        
        elements["second", default: -1] += 2
        
        XCTAssertEqual(elements.count, 2)
        XCTAssertEqual(elements["first"], 0)
        XCTAssertEqual(elements["second"], 1)
        XCTAssertEqual(elements, ["first": 0, "second": 1])
    }
    
    func test_DictionaryWithElements_AfterAddingElementForNewKey_ContainsExistingKeyValuePairFollowedByNewKeyAndValue() {
        var elements: OrderedDictionary = ["first": 0, "second": 1]
        
        elements["third"] = 2
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements["first"], 0)
        XCTAssertEqual(elements["second"], 1)
        XCTAssertEqual(elements["third"], 2)
    }
    
    func test_DictionaryWithElements_AfterAddingElementForNewKey_ContainsExistingElementsFollowedByNewElement() {
        var elements: OrderedDictionary = ["first": 0, "second": 1]
        
        elements["third"] = 2
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements[0].key, "first")
        XCTAssertEqual(elements[0].value, 0)
        XCTAssertEqual(elements[1].key, "second")
        XCTAssertEqual(elements[1].value, 1)
        XCTAssertEqual(elements[2].key, "third")
        XCTAssertEqual(elements[2].value, 2)
        XCTAssertEqual(elements, ["first": 0, "second": 1, "third": 2])
    }
    
    func test_DictionaryWithElements_AfterSubscriptingElementWithDefaultForNewKey_CallsDefaultValueAndExistingKeyValuePairFollowedByNewKeyAndValue() {
        var elements: OrderedDictionary = ["first": 0, "second": 1]
        
        elements["third", default: 1] += 1
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements["first"], 0)
        XCTAssertEqual(elements["second"], 1)
        XCTAssertEqual(elements["third"], 2)
    }
    
    func test_DictionaryWithElements_AfterSubscriptingElementWithDefaultForNewKey_ContainsExistingElementsFollowedByNewElement() {
        var elements: OrderedDictionary = ["first": 0, "second": 1]
        
        elements["third", default: 1] += 1
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements[0].key, "first")
        XCTAssertEqual(elements[0].value, 0)
        XCTAssertEqual(elements[1].key, "second")
        XCTAssertEqual(elements[1].value, 1)
        XCTAssertEqual(elements[2].key, "third")
        XCTAssertEqual(elements[2].value, 2)
        XCTAssertEqual(elements, ["first": 0, "second": 1, "third": 2])
    }
    
    // MARK: Updating Elements in an OrderedDictionary
    
    func test_DictionaryWithOneElement_AfterUpdatingValueForOnlyKey_ContainsOnlyNewValueForKey() {
        var elements: OrderedDictionary = ["first": 0]
     
        elements["first"] = 1
        
        XCTAssertEqual(elements.count, 1)
        XCTAssertEqual(elements, ["first": 1])
    }
    
    func test_DictionaryWithOneElement_AfterSubscritingWithDefaultForOnlyKey_DefaultValueIsNotCalledAndContainsNewValueForKey() {
        var elements: OrderedDictionary = ["first": 0]
        
        elements["first", default: 2] += 1
        
        XCTAssertEqual(elements.count, 1)
        XCTAssertEqual(elements, ["first": 1])
    }
    
    func test_DictionaryWithElements_AfterUpdatingValueForExistingKey_ContainsExpectedKeysAndValues() {
        var elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
     
        elements["second"] = 2
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements["first"], 0)
        XCTAssertEqual(elements["second"], 2)
        XCTAssertEqual(elements["third"], 2)
    }
    
    func test_DictionaryWithElements_AfterUpdatingValueForExistingKey_ContainsElementsInCorrectOrder() {
        var elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        
        elements["second"] = 2
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements[0].key, "first")
        XCTAssertEqual(elements[0].value, 0)
        XCTAssertEqual(elements[1].key, "second")
        XCTAssertEqual(elements[1].value, 2)
        XCTAssertEqual(elements[2].key, "third")
        XCTAssertEqual(elements[2].value, 2)
        XCTAssertEqual(elements, ["first": 0, "second": 2, "third": 2])
    }
    
    func test_DictionaryWithElements_AfterSubscritingWithDefaultForExistingKey_DefaultValueIsNotCalledAndContainsExpectedKeysAndValues() {
        var elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        
        elements["second", default: 3] += 1
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements["first"], 0)
        XCTAssertEqual(elements["second"], 2)
        XCTAssertEqual(elements["third"], 2)
    }
    
    func test_DictionaryWithElements_AfterSubscritingWithDefaultForExistingKey_DefaultValueIsNotCalledAndContainsElementsInCorrectOrder() {
        var elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        
        elements["second", default: 3] += 1
        
        XCTAssertEqual(elements.count, 3)
        XCTAssertEqual(elements[0].key, "first")
        XCTAssertEqual(elements[0].value, 0)
        XCTAssertEqual(elements[1].key, "second")
        XCTAssertEqual(elements[1].value, 2)
        XCTAssertEqual(elements[2].key, "third")
        XCTAssertEqual(elements[2].value, 2)
        XCTAssertEqual(elements, ["first": 0, "second": 2, "third": 2])
    }
    
    // MARK: Remove Elements in an Ordered Dictionary
    
    func test_EmptyDictionary_AfterRemovingValueForKey_IsStillEmpty() {
        var elements = OrderedDictionary<String, Int>()
        XCTAssertTrue(elements.isEmpty)
     
        elements["first"] = nil
        
        XCTAssertTrue(elements.isEmpty)
        XCTAssertEqual(elements, [:])
    }
    
    func test_DictionaryWithOneElement_AfterRemovingValueForKey_IsEmpty() {
        var elements: OrderedDictionary = ["first": 0]
        
        elements["first"] = nil
        
        XCTAssertTrue(elements.isEmpty)
        XCTAssertEqual(elements, [:])
    }
    
    func test_DictionaryWithMultipleElements_AfterRemovingValueForKey_ContainsRemainingElements() {
        var elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        
        elements["first"] = nil
        
        XCTAssertEqual(elements.count, 2)
        XCTAssertEqual(elements["second"], 1)
        XCTAssertEqual(elements["third"], 2)
    }
    
    func test_DictionaryWithMultipleElements_AfterRemovingValueForKey_ContainsElementsInExpectedOrder() {
        var elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2]
        
        elements["first"] = nil
        
        XCTAssertEqual(elements.count, 2)
        XCTAssertEqual(elements[0].key, "second")
        XCTAssertEqual(elements[0].value, 1)
        XCTAssertEqual(elements[1].key, "third")
        XCTAssertEqual(elements[1].value, 2)
        XCTAssertEqual(elements, ["second": 1, "third": 2])
    }
}
