//
//  SongTestMacros.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest

func assertThat(
    _ songs: [Song],
    areEqualTo expectedSongs: [Song],
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    guard songs.count == expectedSongs.count else {
        let failureExplanation = "Both arrays don't have the same size. Expected: \(expectedSongs.count). Got: \(songs.count)."
        XCTFail(
            [failureExplanation, message()].nonEmptyJoined(separator: " "),
            file: file,
            line: line
        )
        return
    }
    
    for (index, pair) in zip(songs, expectedSongs).enumerated() {
        let (left, right) = pair
        let failureExplanation = "Songs at index \(index) are not equal."
        
        XCTAssertEqual(
            left,
            right,
            [failureExplanation, message()].nonEmptyJoined(separator: " "),
            file: file,
            line: line
        )
    }
}
