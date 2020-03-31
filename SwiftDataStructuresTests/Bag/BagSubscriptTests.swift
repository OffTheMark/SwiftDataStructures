//
//  BagSubscriptTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-31.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class BagSubscriptTests: XCTestCase {
    // MARK: Changing Count of Items in an Empty Bag
    
    func test_EmptyBag_AfterSettingCountOfItemToZero_HasCorrectCountOfElement() {
        var bag = Bag<String>()
        
        bag["element"] = 0
        
        XCTAssertEqual(bag["element"], 0)
        XCTAssertFalse(bag.containsItem("element"))
    }
    
    func test_EmptyBag_AfterSettingCountOfItemToZero_IsEmpty() {
        var bag = Bag<String>()
        
        bag["element"] = 0
        
        XCTAssertEqual(bag.count, 0)
        XCTAssertEqual(bag, [:])
    }
    
    func test_EmptyBag_AfterSettingCountOfItem_HasCorrectCountOfElement() {
        var bag = Bag<String>()
        
        bag["element"] = 1
        
        XCTAssertEqual(bag["element"], 1)
        XCTAssertTrue(bag.containsItem("element"))
    }
    
    func test_EmptyBag_AfterSettingCountOfItem_ContainsCorrectElements() {
        var bag = Bag<String>()
        
        bag["element"] = 1
        
        XCTAssertEqual(bag.count, 1)
        XCTAssertEqual(bag, ["element": 1])
    }
    
    func test_EmptyBag_AfterSettingCountOfItemInPlace_HasCorrectCountOfElement() {
        var bag = Bag<String>()
        
        bag["element"] += 3
        
        XCTAssertEqual(bag["element"], 3)
        XCTAssertTrue(bag.containsItem("element"))
    }
    
    func test_EmptyBag_AfterSettingCountOfItemInPlace_ContainsCorrectElements() {
        var bag = Bag<String>()
        
        bag["element"] += 3
        
        XCTAssertEqual(bag.count, 1)
        XCTAssertEqual(bag, ["element": 3])
    }
    
    // MARK: Changing Count of Items in a Non-Empty Bag
    
    func test_BagWithElements_AfterSettingCountOfExistingItemToZero_HasCorrectCountOfElement() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["element"] = 0
        
        XCTAssertEqual(bag["element"], 0)
        XCTAssertFalse(bag.containsItem("element"))
    }
    
    func test_BagWithElements_AfterSettingCountOfExistingItemToZero_ContainsCorrectElements() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["element"] = 0
        
        XCTAssertEqual(bag.count, 1)
        XCTAssertEqual(bag, ["otherElement": 1])
    }
    
    func test_BagWithElements_AfterSettingCountOfExistingItemToCountOtherThanZero_HasCorrectCountOfElement() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["element"] = 5
        
        XCTAssertEqual(bag["element"], 5)
        XCTAssertTrue(bag.containsItem("element"))
    }
    
    func test_BagWithElements_AfterSettingCountOfExistingItemToCountOtherThanZero_ContainsCorrectElements() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["element"] = 5
        
        XCTAssertEqual(bag.count, 2)
        XCTAssertEqual(bag, ["element": 5, "otherElement": 1])
    }
    
    func test_BagWithElements_AfterSettingCountOfExistingItemInPlace_HasCorrectCountOfElement() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["element"] -= 2
        
        XCTAssertEqual(bag["element"], 2)
        XCTAssertTrue(bag.containsItem("element"))
    }
    
    func test_BagWithElements_AfterSettingCountOfExistingItemInPlace_ContainsCorrectElements() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["element"] -= 2
        
        XCTAssertEqual(bag.count, 2)
        XCTAssertEqual(bag, ["element": 2, "otherElement": 1])
    }
    
    func test_BagWithElements_AfterSettingCountOfNewItemToZero_HasCorrectCountOfElement() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["yetAnotherElement"] = 0
        
        XCTAssertEqual(bag["yetAnotherElement"], 0)
        XCTAssertFalse(bag.containsItem("yetAnotherElement"))
    }
    
    func test_BagWithElements_AfterSettingCountOfNewItemToZero_ContainsCorrectElements() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["yetAnotherElement"] = 0
        
        XCTAssertEqual(bag.count, 2)
        XCTAssertEqual(bag, ["element": 4, "otherElement": 1])
    }
    
    func test_BagWithElements_AfterSettingCountOfNewItemToCountOtherThanZero_HasCorrectCountOfElement() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["yetAnotherElement"] = 3
        
        XCTAssertEqual(bag["yetAnotherElement"], 3)
        XCTAssertTrue(bag.containsItem("yetAnotherElement"))
    }
    
    func test_BagWithElements_AfterSettingCountOfNewItemToCountOtherThanZero_ContainsCorrectElements() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["yetAnotherElement"] = 3
        
        XCTAssertEqual(bag.count, 3)
        XCTAssertEqual(bag, ["element": 4, "otherElement": 1, "yetAnotherElement": 3])
    }
    
    func test_BagWithElements_AfterSettingCountOfNewItemInPlace_HasCorrectCountOfElement() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["yetAnotherElement"] += 6
        
        XCTAssertEqual(bag["yetAnotherElement"], 6)
        XCTAssertTrue(bag.containsItem("yetAnotherElement"))
    }
    
    func test_BagWithElements_AfterSettingCountOfNewItemInPlace_ContainsCorrectElements() {
        var bag: Bag = ["element": 4, "otherElement": 1]
        
        bag["yetAnotherElement"] += 6
        
        XCTAssertEqual(bag.count, 3)
        XCTAssertEqual(bag, ["element": 4, "otherElement": 1, "yetAnotherElement": 6])
    }
}
