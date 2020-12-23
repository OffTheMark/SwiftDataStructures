//
//  LinkedListGetElementsTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class LinkedListGetElementsTests: XCTestCase {
    // MARK: Get Element at Position

    func test_ListWithOneElement_WhenGettingFirstAndLast_ReturnsElement() {
        let list: LinkedList = [0]

        XCTAssertEqual(list.first, 0)
        XCTAssertEqual(list.last, 0)
    }

    func test_ListWithElements_WhenGettingFirst_ReturnsExpectedElement() {
        let list: LinkedList = [4, 3, 2, 1, 0]

        XCTAssertEqual(list.first, 4)
    }

    func test_ListWithElements_WhenGettingLast_ReturnsExpectedElement() {
        let list: LinkedList = [4, 3, 2, 1, 0]

        XCTAssertEqual(list.last, 0)
    }

    func test_ListWithElements_WhenGettingElementByIndex_ReturnsExpectedElements() {
        let list: LinkedList = [4, 3, 2, 1, 0]

        XCTAssertEqual(list[list.startIndex], 4)
        XCTAssertEqual(list[list.index(list.startIndex, offsetBy: 1)], 3)
        XCTAssertEqual(list[list.index(list.startIndex, offsetBy: 2)], 2)
        XCTAssertEqual(list[list.index(list.startIndex, offsetBy: 3)], 1)
        XCTAssertEqual(list[list.index(list.startIndex, offsetBy: 4)], 0)
    }

    // MARK: Set Element at Position

    func test_ListWithElements_AfterSettingElementAtSubscriptToNewValue_ContainsExistingElementsWithElementAtSubscriptChanged() {
        var list: LinkedList = [1, 2, 3, 4, 5]

        list[list.index(list.startIndex, offsetBy: 2)] = 6

        XCTAssertEqual(list, [1, 2, 6, 4, 5])
    }

    func test_CopyOfListWithElements_AfterSettingElementAtSubscriptToNewValue_ContainsExistingElementsWithElementAtSubscriptChangedAndOriginalIsUnchanged() {
        let original: LinkedList = [1, 2, 3, 4, 5]
        var copy = original

        copy[copy.index(copy.startIndex, offsetBy: 2)] = 6

        XCTAssertEqual(original, [1, 2, 3, 4, 5])
        XCTAssertEqual(copy, [1, 2, 6, 4, 5])
    }
}
