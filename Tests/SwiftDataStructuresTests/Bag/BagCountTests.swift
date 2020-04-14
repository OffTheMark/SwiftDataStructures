//
//  BagCountTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-31.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class BagCountTests: XCTestCase {
    func test_EmptyBag_HasCorrectCounts() {
        let emptyBag = Bag<Int>()
        
        XCTAssertTrue(emptyBag.isEmpty)
        XCTAssertEqual(emptyBag.count, 0)
        XCTAssertEqual(emptyBag.totalCount, 0)
    }
    
    func test_BagWithElements_HasCorrectCount() {
        let bag: Bag = ["element": 3, "otherElement": 1, "yetAnotherElement": 5]
        
        XCTAssertFalse(bag.isEmpty)
        XCTAssertEqual(bag.count, 3)
    }
    
    func test_BagWithElements_HasCorrectCountsByElement() {
        let bag: Bag = ["element": 3, "otherElement": 1, "yetAnotherElement": 5]
        
        XCTAssertEqual(bag.totalCount, 9)
        XCTAssertEqual(bag.count(of: "element"), 3)
        XCTAssertEqual(bag.count(of: "otherElement"), 1)
        XCTAssertEqual(bag.count(of: "yetAnotherElement"), 5)
    }
}
