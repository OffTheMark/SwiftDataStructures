//
//  LinkedListRangeReplaceTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-03-27.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class LinkedListRangeReplaceTests: XCTestCase {
    // MARK: Replacing Elements at Start
    
    func test_ListWithElements_AfterRemovingElementsAtStat_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.startIndex ..< list.index(list.startIndex, offsetBy: 4)
        list.removeSubrange(subrange)
        
        XCTAssertEqual(list.count, 6)
        XCTAssertEqual(list, [4, 5, 6, 7, 8, 9])
    }
    
    func test_ListWithElements_AfterReplacingElementsAtStartWithLessElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.startIndex ..< list.index(list.startIndex, offsetBy: 4)
        list.replaceSubrange(subrange, with: 10...11)
        
        XCTAssertEqual(list.count, 8)
        XCTAssertEqual(list, [10, 11, 4, 5, 6, 7, 8, 9])
    }
    
    func test_ListWithElements_AfterReplacingElementsAtStartWithSameNumberOfElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.startIndex ..< list.index(list.startIndex, offsetBy: 4)
        list.replaceSubrange(subrange, with: 10...13)
        
        XCTAssertEqual(list.count, 10)
        XCTAssertEqual(list, [10, 11, 12, 13, 4, 5, 6, 7, 8, 9])
    }
    
    func test_ListWithElements_AfterReplacingElementsAtStartWithMoreElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.startIndex ..< list.index(list.startIndex, offsetBy: 4)
        list.replaceSubrange(subrange, with: 10...15)
        
        XCTAssertEqual(list.count, 12)
        XCTAssertEqual(list, [10, 11, 12, 13, 14, 15, 4, 5, 6, 7, 8, 9])
    }
    
    // MARK: Replacing Elements in Middle
    
    func test_ListWithElements_AfterRemovingElementsInMiddle_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 4) ..< list.index(list.startIndex, offsetBy: 8)
        list.removeSubrange(subrange)
        
        XCTAssertEqual(list.count, 6)
        XCTAssertEqual(list, [0, 1, 2, 3, 8, 9])
    }
    
    func test_ListWithElements_AfterReplacingElementsInMiddleWithLessElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 4) ..< list.index(list.startIndex, offsetBy: 8)
        list.replaceSubrange(subrange, with: 10...13)
        
        XCTAssertEqual(list.count, 10)
        XCTAssertEqual(list, [0, 1, 2, 3, 10, 11, 12, 13, 8, 9])
    }
    
    func test_ListWithElements_AfterReplacingElementsInMiddleWithSameNumberOfElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 4) ..< list.index(list.startIndex, offsetBy: 8)
        list.replaceSubrange(subrange, with: 10...15)
        
        XCTAssertEqual(list.count, 12)
        XCTAssertEqual(list, [0, 1, 2, 3, 10, 11, 12, 13, 14, 15, 8, 9])
    }
    
    func test_ListWithElements_AfterReplacingElementsInMiddleWithMoreElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 3) ..< list.index(list.startIndex, offsetBy: 6)
        list.replaceSubrange(subrange, with: 10...14)
        
        XCTAssertEqual(list.count, 12)
        XCTAssertEqual(list, [0, 1, 2, 10, 11, 12, 13, 14, 6, 7, 8, 9])
    }
    
    // MARK: Replacing Elements at End
    
    func test_ListWithElements_AfterRemovingElementsAtEnd_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 6) ..< list.index(list.startIndex, offsetBy: 10)
        list.removeSubrange(subrange)
        
        XCTAssertEqual(list.count, 6)
        XCTAssertEqual(list, [0, 1, 2, 3, 4, 5])
    }
    
    func test_ListWithElements_AfterReplacingElementsAtEndWithLessElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 6) ..< list.index(list.startIndex, offsetBy: 10)
        list.replaceSubrange(subrange, with: 10...11)
        
        XCTAssertEqual(list.count, 8)
        XCTAssertEqual(list, [0, 1, 2, 3, 4, 5, 10, 11])
    }
    
    func test_ListWithElements_AfterReplacingElementsAtEndWithSameNumberOfElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 6) ..< list.index(list.startIndex, offsetBy: 10)
        list.replaceSubrange(subrange, with: 10...13)
        
        XCTAssertEqual(list.count, 10)
        XCTAssertEqual(list, [0, 1, 2, 3, 4, 5, 10, 11, 12, 13])
    }
    
    func test_ListWithElements_AfterReplacngElementsAtEndWithMoreElements_ContainsExpectedElements() {
        var list = LinkedList(0..<10)
        
        let subrange = list.index(list.startIndex, offsetBy: 6) ..< list.index(list.startIndex, offsetBy: 10)
        list.replaceSubrange(subrange, with: 10...15)
        
        XCTAssertEqual(list.count, 12)
        XCTAssertEqual(list, [0, 1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15])
    }
    
    // MARK: Replacing Elements at Start (Copy-on-Write)
    
    func test_CopyOfListWithElements_AfterRemovingElementsAtStat_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.startIndex ..< copy.index(copy.startIndex, offsetBy: 4)
        copy.removeSubrange(subrange)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 6)
        XCTAssertEqual(copy, [4, 5, 6, 7, 8, 9])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsAtStartWithLessElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.startIndex ..< copy.index(copy.startIndex, offsetBy: 4)
        copy.replaceSubrange(subrange, with: 10...11)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 8)
        XCTAssertEqual(copy, [10, 11, 4, 5, 6, 7, 8, 9])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsAtStartWithSameNumberOfElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.startIndex ..< copy.index(copy.startIndex, offsetBy: 4)
        copy.replaceSubrange(subrange, with: 10...13)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 10)
        XCTAssertEqual(copy, [10, 11, 12, 13, 4, 5, 6, 7, 8, 9])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsAtStartWithMoreElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.startIndex ..< copy.index(copy.startIndex, offsetBy: 4)
        copy.replaceSubrange(subrange, with: 10...15)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 12)
        XCTAssertEqual(copy, [10, 11, 12, 13, 14, 15, 4, 5, 6, 7, 8, 9])
    }
    
    // MARK: Replacing Elements in Middle (Copy-on-Write)
    
    func test_CopyOfListWithElements_AfterRemovingElementsInMiddle_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 4) ..< copy.index(copy.startIndex, offsetBy: 8)
        copy.removeSubrange(subrange)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 6)
        XCTAssertEqual(copy, [0, 1, 2, 3, 8, 9])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsInMiddleWithLessElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 4) ..< copy.index(copy.startIndex, offsetBy: 8)
        copy.replaceSubrange(subrange, with: 10...13)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 10)
        XCTAssertEqual(copy, [0, 1, 2, 3, 10, 11, 12, 13, 8, 9])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsInMiddleWithSameNumberOfElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 4) ..< copy.index(copy.startIndex, offsetBy: 8)
        copy.replaceSubrange(subrange, with: 10...15)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 12)
        XCTAssertEqual(copy, [0, 1, 2, 3, 10, 11, 12, 13, 14, 15, 8, 9])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsInMiddleWithMoreElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 3) ..< copy.index(copy.startIndex, offsetBy: 6)
        copy.replaceSubrange(subrange, with: 10...14)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 12)
        XCTAssertEqual(copy, [0, 1, 2, 10, 11, 12, 13, 14, 6, 7, 8, 9])
    }
    
    // MARK: Replacing Elements at End (Copy-on-Write)
    
    func test_CopyOfListWithElements_AfterRemovingElementsAtEnd_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 6) ..< copy.index(copy.startIndex, offsetBy: 10)
        copy.removeSubrange(subrange)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 6)
        XCTAssertEqual(copy, [0, 1, 2, 3, 4, 5])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsAtEndWithLessElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 6) ..< copy.index(copy.startIndex, offsetBy: 10)
        copy.replaceSubrange(subrange, with: 10...11)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 8)
        XCTAssertEqual(copy, [0, 1, 2, 3, 4, 5, 10, 11])
    }
    
    func test_CopyOfListWithElements_AfterReplacingElementsAtEndWithSameNumberOfElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 6) ..< copy.index(copy.startIndex, offsetBy: 10)
        copy.replaceSubrange(subrange, with: 10...13)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 10)
        XCTAssertEqual(copy, [0, 1, 2, 3, 4, 5, 10, 11, 12, 13])
    }
    
    func test_CopyOfListWithElements_AfterReplacngElementsAtEndWithMoreElements_ContainsExpectedElementsAndOriginalIsUnchanged() {
        let original = LinkedList(0..<10)
        var copy = original
        
        let subrange = copy.index(copy.startIndex, offsetBy: 6) ..< copy.index(copy.startIndex, offsetBy: 10)
        copy.replaceSubrange(subrange, with: 10...15)
        
        XCTAssertEqual(original.count, 10)
        XCTAssertEqual(original, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        XCTAssertEqual(copy.count, 12)
        XCTAssertEqual(copy, [0, 1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15])
    }
    
    // MARK: Inserting Elements in the Middle
    
    func test_insertAt_ifMultipleElementsAreInsertedInTheMiddle_containsExpectedElements() {
        var list = LinkedList(0..<5)
        
        list.insert(5, at: list.index(after: list.startIndex))
        list.insert(6, at: list.index(list.startIndex, offsetBy: 2))
        list.insert(7, at: list.index(list.startIndex, offsetBy: 3))
        
        XCTAssertEqual(list.count, 8)
        XCTAssertEqual(list, [0, 5, 6, 7, 1, 2, 3, 4])
    }
}
