//
//  SortCriterionSortTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class SortCriterionSortTests: XCTestCase {
    // MARK: Sort a Sequence by Keypaths with Non-Nil Values
    
    func test_SongsWithSameArtist_WhenSortingByArtist_ReturnsSongsInSameOrder() {
        // Given
        let marqueeMoon = Album(title: "Marquee Moon", artist: "Television", year: 1977)
        let songs = [
            Song(title: "See No Evil", album: marqueeMoon),
            Song(title: "Venus", album: marqueeMoon),
            Song(title: "Friction", album: marqueeMoon),
            Song(title: "Marquee Moon", album: marqueeMoon),
            Song(title: "Elevation", album: marqueeMoon),
            Song(title: "Guiding Light", album: marqueeMoon),
            Song(title: "Prove It", album: marqueeMoon),
            Song(title: "Torn Curtain", album: marqueeMoon)
        ]
        
        // When
        let sorted = songs.sorted(by: \.album.artist)
        
        // Then
        assertThat(sorted, areEqualTo: songs)
    }
    
    func test_Songs_WhenSortingByTitleDescending_ReturnsSongsInCorrectOrder() {
        // Given
        let marqueeMoon = Album(title: "Marquee Moon", artist: "Television", year: 1977)
        let songs = [
            Song(title: "See No Evil", album: marqueeMoon),
            Song(title: "Venus", album: marqueeMoon),
            Song(title: "Friction", album: marqueeMoon),
            Song(title: "Marquee Moon", album: marqueeMoon),
            Song(title: "Elevation", album: marqueeMoon),
            Song(title: "Guiding Light", album: marqueeMoon),
            Song(title: "Prove It", album: marqueeMoon),
            Song(title: "Torn Curtain", album: marqueeMoon)
        ]
        let expectedSongs = [
            Song(title: "Venus", album: marqueeMoon),
            Song(title: "Torn Curtain", album: marqueeMoon),
            Song(title: "See No Evil", album: marqueeMoon),
            Song(title: "Prove It", album: marqueeMoon),
            Song(title: "Marquee Moon", album: marqueeMoon),
            Song(title: "Guiding Light", album: marqueeMoon),
            Song(title: "Friction", album: marqueeMoon),
            Song(title: "Elevation", album: marqueeMoon)
        ]
        
        // When
        let sorted = songs.sorted(by: \.title, order: .descending)
        
        // Then
        assertThat(sorted, areEqualTo: expectedSongs)
    }
    
    func test_SongsFromDifferentAlbums_WhenSortingByArtistAscendingAndAlbumYearDescending_ReturnsSongsInCorrectOrder() {
        // Given
        let songs = [
            Song(
                title: "Alternative Ulster",
                album: Album(
                    title: "Inflammable Material",
                    artist: "Stiff Little Fingers",
                    year: 1979
                )
            ),
            Song(
                title: "12XU",
                album: Album(
                    title: "Pink Flag",
                    artist: "Wire",
                    year: 1977
                )
            ),
            Song(
                title: "I Am the Fly",
                album: Album(
                    title: "Chairs Missing",
                    artist: "Wire",
                    year: 1978
                )
            ),
            Song(
                title: "Disorder",
                album: Album(
                    title: "Unknown Pleasures",
                    artist: "Joy Division",
                    year: 1979
                )
            )
        ]
        let expectedSongs = [
            Song(
                title: "Disorder",
                album: Album(
                    title: "Unknown Pleasures",
                    artist: "Joy Division",
                    year: 1979
                )
            ),
            Song(
                title: "Alternative Ulster",
                album: Album(
                    title: "Inflammable Material",
                    artist: "Stiff Little Fingers",
                    year: 1979
                )
            ),
            Song(
                title: "I Am the Fly",
                album: Album(
                    title: "Chairs Missing",
                    artist: "Wire",
                    year: 1978
                )
            ),
            Song(
                title: "12XU",
                album: Album(
                    title: "Pink Flag",
                    artist: "Wire",
                    year: 1977
                )
            )
        ]
        
        // When
        let sorted = songs.sorted(
            by: [
                SortCriterion(keyPath: \.album.artist, order: .ascending),
                SortCriterion(keyPath: \.album.year, order: .descending)
            ]
        )
        
        // Then
        assertThat(sorted, areEqualTo: expectedSongs)
    }
}

fileprivate func assertThat(
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

// MARK: - Song

fileprivate struct Song {
    let title: String
    let album: Album
    let trackNumber: Int?
    
    init(title: String, album: Album, trackNumber: Int? = nil) {
        self.title = title
        self.album = album
        self.trackNumber = trackNumber
    }
}

// MARK: Equatable

extension Song: Equatable {}

// MARK: - Artist

fileprivate struct Artist {
    let name: String
}

// MARK: Equatable

extension Artist: Equatable {}

// MARK: ExpressibleByStringLiteral

extension Artist: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(name: value)
    }
}

// MARK: Comparable

extension Artist: Comparable {
    static func < (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.name < rhs.name
    }
}

// MARK: - Album

fileprivate struct Album {
    let title: String
    let artist: Artist
    let year: Int
}

// MARK: Equatable

extension Album: Equatable {}
