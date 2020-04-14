//
//  DequeUpdateTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class DequeUpdateTests: XCTestCase {
    // MARK: Adding Elements to an Empty Deque

    func test_EmptyDeque_AfterPrependingElement_ContainsOnlyElement() {
        var deque = Deque<Int>()

        deque.prepend(0)

        XCTAssertEqual(deque, [0])
    }

    func test_EmptyDeque_AfterAppendingElement_ContainsOnlyElement() {
        var deque = Deque<Int>()

        deque.append(0)

        XCTAssertEqual(deque, [0])
    }

    // MARK: Adding Elements to a Non-Empty Deque

    func test_DequeWithOneElement_AfterPrependingNewElement_ContainsNewElementFollowedByExistingElement() {
        var deque: Deque = [1]

        deque.prepend(0)

        XCTAssertEqual(deque, [0, 1])
    }

    func test_DequeWithOneElement_AfterAppendingNewElement_ContainsExistingElementFollowedByNewElement() {
        var deque: Deque = [1]

        deque.append(2)

        XCTAssertEqual(deque, [1, 2])
    }

    func test_DequeWithElements_AfterPrependingNewElement_ContainsNewElementFollowedByExistingElements() {
        var deque: Deque = [1, 2, 3, 4, 5]

        deque.prepend(0)

        XCTAssertEqual(deque, [0, 1, 2, 3, 4, 5])
    }

    func test_DequeWithElements_AfterAppendingNewElement_ContainsExistingElementsFollowedByNewElement() {
        var deque: Deque = [0, 1, 2, 3, 4]

        deque.append(5)

        XCTAssertEqual(deque, [0, 1, 2, 3, 4, 5])
    }

    // MARK: Adding Elements to a Copy of a Non-Empty List (Copy-on-Write)

    func test_CopyOfDequeWithOneElement_AfterPrependingNewElement_ContainsNewElementFollowedByExistingElementAndOriginalIsUnchanged() {
        let original: Deque = [1]
        var copy = original

        copy.prepend(0)

        XCTAssertEqual(original, [1])
        XCTAssertEqual(copy, [0, 1])
    }

    func test_CopyOfDequeWithOneElement_AfterAppendingNewElement_ContainsExistingElementFollowedByNewElementAndOriginalIsUnchanged() {
        let original: Deque = [0]
        var copy = original

        copy.append(1)

        XCTAssertEqual(original, [0])
        XCTAssertEqual(copy, [0, 1])
    }

    func test_CopyOfDequeWithElements_AfterPrependingNewElement_ContainsNewElementFollowedByElementsAndOriginalIsUnchanged() {
        let original: Deque = [1, 2, 3, 4, 5]
        var copy = original

        copy.prepend(0)

        XCTAssertEqual(original, [1, 2, 3, 4, 5])
        XCTAssertEqual(copy, [0, 1, 2, 3, 4, 5])
    }

    func test_CopyOfDequeWithElements_AfterAppendingNewElement_ContainsElementsFollowedByNewElementAndOriginalIsUnchanged() {
        let original: Deque = [0, 1, 2, 3, 4]
        var copy = original

        copy.append(5)

        XCTAssertEqual(original, [0, 1, 2, 3, 4])
        XCTAssertEqual(copy, [0, 1, 2, 3, 4, 5])
    }
    
    // MARK: Removing Elements in a Non-Empty Deque

    func test_DequeWithOneElement_AfterRemovingFirst_IsEmpty() {
        var deque: Deque = [0]

        let removed = deque.removeFirst()

        XCTAssertEqual(removed, 0)
        XCTAssertTrue(deque.isEmpty)
        XCTAssertEqual(deque, [])
    }

    func test_DequeWithOneElement_AfterRemovingLast_IsEmpty() {
        var deque: Deque = [0]

        let removed = deque.removeLast()

        XCTAssertEqual(removed, 0)
        XCTAssertTrue(deque.isEmpty)
        XCTAssertEqual(deque, [])
    }

    func test_DequeWithElements_AfterRemovingFirst_ContainsElementsExceptFirst() {
        var deque: Deque = [0, 1, 2, 3, 4, 5]

        let removed = deque.removeFirst()

        XCTAssertEqual(removed, 0)
        XCTAssertEqual(deque, [1, 2, 3, 4, 5])
    }

    func test_DequeWithElements_AfterRemovingLast_ContainsElementsExceptLast() {
        var deque: Deque = [0, 1, 2, 3, 4, 5]

        let removed = deque.removeLast()

        XCTAssertEqual(removed, 5)
        XCTAssertEqual(deque, [0, 1, 2, 3, 4])
    }

    func test_DequeWithElements_AfterRemovingAll_IsEmpty() {
        var deque: Deque = [0, 1, 2, 3, 4, 5]

        deque.removeAll()

        XCTAssertTrue(deque.isEmpty)
        XCTAssertEqual(deque, [])
    }

    // MARK: Removing Elements in a Copy of a Non-Empty Deque (Copy-on-Write)

    func test_CopyOfDequeWithOneElement_AfterRemovingFirst_IsEmptyAndOriginalIsUnchanged() {
        let original: Deque = [0]
        var copy = original

        let removed = copy.removeLast()

        XCTAssertEqual(removed, 0)
        XCTAssertTrue(copy.isEmpty)
        XCTAssertEqual(copy, [])
        XCTAssertEqual(original, [0])
    }

    func test_CopyOfDequeWithOneElement_AfterRemovingLast_IsEmptyAndOriginalIsUnchanged() {
        let original: Deque = [0]
        var copy = original

        let removed = copy.removeLast()

        XCTAssertEqual(removed, 0)
        XCTAssertTrue(copy.isEmpty)
        XCTAssertEqual(copy, [])
        XCTAssertEqual(original, [0])
    }

    func test_CopyOfDequeWithElements_AfterRemovingFirst_CopyContainsElementsExceptFirstAndOriginalIsUnchanged() {
        let original: Deque = [0, 1, 2, 3, 4, 5]
        var copy = original

        let removed = copy.removeFirst()

        XCTAssertEqual(removed, 0)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5])
        XCTAssertEqual(copy, [1, 2, 3, 4, 5])
    }

    func test_CopyOfDequeWithElements_AfterRemovingLast_CopyContainsElementsExceptLastAndOriginalIsUnchanged() {
        let original: Deque = [0, 1, 2, 3, 4, 5]
        var copy = original

        let removed = copy.removeLast()

        XCTAssertEqual(removed, 5)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5])
        XCTAssertEqual(copy, [0, 1, 2, 3, 4])
    }

    func test_CopyOfDequeWithElements_AfterRemovingAll_IsEmptyAndOriginalIsUnchanged() {
        let original: Deque = [0, 1, 2, 3, 4, 5]
        var copy = original

        copy.removeAll()

        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5])
        XCTAssertTrue(copy.isEmpty)
        XCTAssertEqual(copy, [])
    }
}
