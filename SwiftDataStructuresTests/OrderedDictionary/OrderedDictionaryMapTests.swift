//
//  OrderedDictionaryMapTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-13.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class OrderedDictionaryMapTests: XCTestCase {
    // MARK: Transform Values of an Ordered Dictionary

    public func test_DictionaryWithElements_AfterMappingValues_ReturnsNewDictionaryWithSameKeysAndTransformedValues() {
        let elements: OrderedDictionary = ["first": 0, "second": 1, "third": 2, "fourth": 3]
        let expected: OrderedDictionary = ["first": "0", "second": "1", "third": "2", "fourth": "3"]
        
        let transformed = elements.mapValues({ String($0) })
        
        XCTAssertEqual(transformed, expected)
    }
    
    func test_DictionaryWithElements_AfterCompactMappingValues_ReturnsNewElementsWithNonNilTransformedElements() {
        let elements: OrderedDictionary = ["first": "1", "second": "2nd", "third": "3", "fourth": "4th"]
        let expected: OrderedDictionary = ["first": 1, "third": 3]
        
        let transformed = elements.compactMapValues({ Int($0) })
        
        XCTAssertEqual(transformed, expected)
    }
}
