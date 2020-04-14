//
//  QueueIterateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-13.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class QueueIterateTests: XCTestCase {
    // MARK: Iterating Over a Queue's Elements

    func test_EmptyQueue_WhenIteratingOverElements_ReturnsNoElements() {
        let elements = Queue<Int>()
        var iterator = elements.makeIterator()
        
        XCTAssertNil(iterator.next())
    }
    
    func test_QueueWithElements_WhenIteratingOverElements_ReturnsElementsInExpectedOrder() {
        let elements: Queue = [4, 3, 2, 1]
        var iterator = elements.makeIterator()
        
        XCTAssertEqual(iterator.next(), 4)
        XCTAssertEqual(iterator.next(), 3)
        XCTAssertEqual(iterator.next(), 2)
        XCTAssertEqual(iterator.next(), 1)
        XCTAssertNil(iterator.next())
    }
}
