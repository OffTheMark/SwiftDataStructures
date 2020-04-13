//
//  QueueGetElementsTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class QueueGetElementsTests: XCTestCase {
    // MARK: Getting Elements in an Empty Queue

    func test_EmptyQueue_AfterGettingFirst_ReturnsNil() {
        let queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        
        let peeked = queue.peek()
        
        XCTAssertNil(peeked)
    }
    
    // MARK: Getting Elements in a Non-Empty Queue

    func test_QueueWithOneElement_AfterGettingFirst_ReturnsOnlyElement() {
        let queue: Queue = [0]
        
        let peeked = queue.peek()
        
        XCTAssertEqual(peeked, 0)
    }

    func test_QueueWitElements_AfterGettingFirst_ReturnsFirstElement() {
        let queue: Queue = [0, 1, 2, 3]
        
        let peeked = queue.peek()
        
        XCTAssertEqual(peeked, 0)
    }
}
