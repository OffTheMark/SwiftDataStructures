//
//  StackGetElementsTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-13.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class StackGetElementsTests: XCTestCase {
    // MARK: Getting Elements in an Empty Stack
    
    func test_EmptyStack_WhenPeeking_ReturnsNil() {
        let stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)
        
        let peeked = stack.peek()
        
        XCTAssertNil(peeked)
    }
    
    func test_EmptyStack_WhenGettingFirst_ReturnsNil() {
        let stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)
        
        XCTAssertNil(stack.first)
    }
    
    func test_EmptyStack_WhenGettingLast_ReturnsNil() {
        let stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)
        
        XCTAssertNil(stack.last)
    }
    
    // MARK: Getting Elements in a Non-Empty Stack

    func test_StackWithOneElement_WhenPeeking_ReturnsOnlyElement() {
        let stack: Stack = [0]
        
        let peeked = stack.peek()
        
        XCTAssertEqual(peeked, 0)
    }
    
    func test_StackWithOneElement_WhenGettingFirst_ReturnsOnlyElement() {
        let stack: Stack = [0]
        
        XCTAssertEqual(stack.first, 0)
    }
    
    func test_StackWithOneElement_WhenGettingLast_ReturnsOnlyElement() {
        let stack: Stack = [0]
        
        XCTAssertEqual(stack.last, 0)
    }
    
    func test_StackWithOneElement_WhenGettingElementsByIndex_ReturnsExpectedElements() {
        let stack: Stack = [0]
        
        XCTAssertEqual(stack[0], 0)
    }

    func test_StackWithElements_WhenPeeking_ReturnsLastElement() {
        let stack: Stack = [3, 2, 1, 0]
        
        let peeked = stack.peek()
        
        XCTAssertEqual(peeked, 0)
    }
    
    func test_StackWithElements_WhenGettingFirst_ReturnsOnlyElement() {
        let stack: Stack = [3, 2, 1, 0]
        
        XCTAssertEqual(stack.first, 3)
    }
    
    func test_StackWithElements_WhenGettingLast_ReturnsOnlyElement() {
        let stack: Stack = [3, 2, 1, 0]
        
        XCTAssertEqual(stack.last, 0)
    }
    
    func test_StackWithElements_WhenGettingElementsByIndex_ReturnsExpectedElements() {
        let stack: Stack = [3, 2, 1, 0]
        
        XCTAssertEqual(stack[0], 3)
        XCTAssertEqual(stack[1], 2)
        XCTAssertEqual(stack[2], 1)
        XCTAssertEqual(stack[3], 0)
    }
}
