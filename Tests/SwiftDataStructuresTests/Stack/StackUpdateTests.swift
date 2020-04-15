//
//  StackUpdateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-13.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class StackUpdateTests: XCTestCase {
    // MARK: Adding Elements to an Empty Stack
    
    func test_EmptyStack_AfterAddingElements_ContainsOnlyElement() {
        var stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)
        
        stack.push(0)
        
        XCTAssertEqual(stack, [0])
    }
    
    // MARK: Adding Elements to a Non-Empty Stack
    
    func test_StackWithOneElement_AfterPushingNewElement_ContainsExistingElementFollowedByNewElement() {
        var stack: Stack = [0]
        
        stack.push(1)
        
        XCTAssertEqual([0, 1], stack)
    }
    
    func test_StackWithElements_AfterPushingNewElement_ContainsExistingElementsFollowedByNewElement() {
        var stack: Stack = [0, 1, 2, 3, 4]
        
        stack.push(5)
        
        XCTAssertEqual(stack, [0, 1, 2, 3, 4, 5])
    }
    
    // MARK: Removing Elements from a Stack
    
    func test_StackWithOneElement_AfterPopping_ReturnsElement() {
        var stack: Stack = [0]
        
        let popped = stack.pop()
        
        XCTAssertEqual(popped, 0)
    }
    
    func test_StackWithOneElement_AfterPopping_IsEmpty() {
        var stack: Stack = [0]
        
        stack.pop()
        
        XCTAssertEqual(stack, [])
    }
    
    func test_StackWithOneElement_AfterRemovingAll_IsEmpty() {
        var stack: Stack = [0]
        
        stack.removeAll()
        
        XCTAssertEqual(stack, [])
    }
    
    func test_StackWithElements_AfterPopping_ReturnsLastElement() {
        var stack: Stack = [0, 1, 2]
        
        let popped = stack.pop()
        
        XCTAssertEqual(popped, 2)
    }
    
    func test_StackWithElements_AfterPopping_ContainsRemainingElements() {
        var stack: Stack = [0, 1, 2]
        
        stack.pop()
        
        XCTAssertEqual(stack, [0, 1])
    }
    
    func test_StackWithElements_AfterRemovingAll_IsEmpty() {
        var stack: Stack = [0, 1, 2]
        
        stack.removeAll()
        
        XCTAssertEqual(stack, [])
    }
}
