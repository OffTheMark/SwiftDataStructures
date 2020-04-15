//
//  GenericTestMacros.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest

// MARK: Require a Value to Be Non-Bil

struct RequireError<T>: LocalizedError {
    let file: StaticString
    let line: UInt
    
    var errorDescription: String? {
        return "A required value of type \(T.self) was nil at line \(line) of file \(file)."
    }
}

func require<T>(
    _ expression: @autoclosure () -> T?,
    file: StaticString = #file,
    line: UInt = #line
    ) throws -> T {
    
    guard let value = expression() else {
        throw RequireError<T>(file: file, line: line)
    }
    
    return value
}

// MARK: Assertions Concerning Collections

func assertThat<C1: Collection, C2: Collection, Element>(
    _ collection: C1,
    containsSameUnsortedElementsAs expectedCollection: C2,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) where Element == C1.Element, Element == C2.Element, Element: Equatable {
    guard collection.count == expectedCollection.count else {
        let failureExplanation = "Both collections don't have the same size. Expected: \(collection.count). Got: \(expectedCollection.count)."
        XCTFail(
            [failureExplanation, message()].nonEmptyJoined(separator: " "),
            file: file,
            line: line
        )
        return
    }
    
    
    let failureExplanation = "\(collection) does not contain the same unsorted elements as \(expectedCollection)."
    
    XCTAssert(
        expectedCollection.allSatisfy({ collection.contains($0) }),
        [failureExplanation, message()].nonEmptyJoined(separator: " "),
        file: file,
        line: line
    )
}
