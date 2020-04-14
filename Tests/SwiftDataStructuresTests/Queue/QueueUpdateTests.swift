//
//  QueueUpdateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class QueueUpdateTests: XCTestCase {
    // MARK: Adding Elements to an Empty Queue
    
    func test_EmptyQueue_AfterEnqueuingElement_ContainsOnlyOneElement() {
        var queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        
        queue.enqueue(0)
        
        XCTAssertEqual(queue, [0])
    }
    
    // MARK: Adding Element to a Non-Empty Queue
    
    func test_QueueWithOneElement_AfterEnqueuingNewElement_ContainsExistingElementFollowedByNewElement() {
        var queue: Queue = [0]
        
        queue.enqueue(1)
        
        XCTAssertEqual(queue, [0, 1])
    }
    
    func test_QueueWithElements_AfterEnqueuingNewElement_ContainsExistingElementsFollowedByNewElement() {
        var queue: Queue = [0, 1, 2, 3, 4]
        
        queue.enqueue(5)
        
        XCTAssertEqual(queue, [0, 1, 2, 3, 4, 5])
    }
    
    // MARK: Removing Elements in a Non-Empty Queue
    
    func test_QueueWithOneElement_AfterDequeuing_ReturnsElement() {
        var queue: Queue = [0]
        
        let dequeued = queue.dequeue()
        
        XCTAssertEqual(dequeued, 0)
    }
    
    func test_QueueWithOneElement_AfterDequeuing_IsEmpty() {
        var queue: Queue = [0]
        
        queue.dequeue()
        
        XCTAssertEqual(queue, [])
    }
    
    func test_QueueWithElements_AfterDequeuing_ReturnsFirstElement() {
        var queue: Queue = [0, 1, 2]
        
        let dequeued = queue.dequeue()
        
        XCTAssertEqual(dequeued, 0)
    }
    
    func test_QueueWithElements_AfterDequeuing_ContainsRemainingElements() {
        var queue: Queue = [0, 1, 2]
        
        queue.dequeue()
        
        XCTAssertEqual(queue, [1, 2])
    }
}
