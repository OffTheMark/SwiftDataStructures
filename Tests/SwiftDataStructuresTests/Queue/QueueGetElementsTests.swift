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

    func test_EmptyQueue_WhenPeeking_ReturnsNil() {
        let queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        
        let peeked = queue.peek()
        
        XCTAssertNil(peeked)
    }
    
    func test_EmptyQueue_WhenGettingFirst_ReturnsNil() {
        let queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        
        XCTAssertNil(queue.first)
    }
    
    func test_EmptyQueue_WhenGettingLast_ReturnsNil() {
        let queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        
        XCTAssertNil(queue.last)
    }
    
    // MARK: Getting Elements in a Non-Empty Queue

    func test_QueueWithOneElement_WhenPeeking_ReturnsOnlyElement() {
        let queue: Queue = [0]
        
        let peeked = queue.peek()
        
        XCTAssertEqual(peeked, 0)
    }
    
    func test_QueueWithOneElement_WhenGettingFirst_ReturnsNil() {
        let queue: Queue = [0]
        
        XCTAssertEqual(queue.first, 0)
    }
    
    func test_QueueWithOneElement_WhenGettingLast_ReturnsNil() {
        let queue: Queue = [0]
        
        XCTAssertEqual(queue.last, 0)
    }
    
    func test_QueueWithOneElement_WhenGettingElementsByIndex_ReturnsExpectedElements() {
        let queue: Queue = [0]
        
        XCTAssertEqual(queue[queue.startIndex], 0)
    }

    func test_QueueWithElements_WhenPeeking_ReturnsFirstElement() {
        let queue: Queue = [0, 1, 2, 3]
        
        let peeked = queue.peek()
        
        XCTAssertEqual(peeked, 0)
    }
    
    func test_QueueWithElements_WhenGettingFirst_ReturnsNil() {
        let queue: Queue = [3, 2, 1, 0]
        
        XCTAssertEqual(queue.first, 3)
    }
    
    func test_QueueWithElements_WhenGettingLast_ReturnsNil() {
        let queue: Queue = [3, 2, 1, 0]
        
        XCTAssertEqual(queue.last, 0)
    }
    
    func test_QueueWithElements_WhenGettingElementsByIndex_ReturnsExpectedElements() {
        let queue: Queue = [3, 2, 1, 0]
        
        XCTAssertEqual(queue[queue.startIndex], 3)
        XCTAssertEqual(queue[queue.index(after: queue.startIndex)], 2)
        XCTAssertEqual(queue[queue.index(queue.startIndex, offsetBy: 2)], 1)
        XCTAssertEqual(queue[queue.index(queue.startIndex, offsetBy: 3)], 0)
    }
}
