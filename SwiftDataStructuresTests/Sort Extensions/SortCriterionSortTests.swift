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
    // MARK: Sort a Sequence by a Keypath with Non-Optional Value
    
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
        var sortedInPlace = songs
        sortedInPlace.sort(by: \.album.artist)
        
        // Then
        assertThat(sorted, areEqualTo: songs)
        assertThat(sortedInPlace, areEqualTo: songs)
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
        let expected = [
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
        var sortedInPlace = songs
        sortedInPlace.sort(by: \.title, order: .descending)
        
        // Then
        assertThat(sorted, areEqualTo: expected)
        assertThat(sortedInPlace, areEqualTo: expected)
    }
    
    // MARK: Sort a Sequence by a Keypath with Optional Value
    
    func test_SongsWithSortIndex_WhenSortingBySortIndexAscending_ReturnsSongsInCorrectOrder() {
        // Given
        let remainInLight = Album(title: "Remain in Light", artist: "Talking Heads", year: 1980)
        let songs = [
            Song(title: "Once in a Lifetime", album: remainInLight, trackNumber: 4),
            Song(title: "The Great Curve", album: remainInLight, trackNumber: 3),
            Song(title: "Listening Wind", album: remainInLight, trackNumber: 7),
            Song(title: "The Overload", album: remainInLight, trackNumber: 8),
            Song(title: "House in Motion", album: remainInLight, trackNumber: 5),
            Song(title: "Born Under the Punches (The Heat Goes On)", album: remainInLight, trackNumber: 1),
            Song(title: "Seen and Not Seen", album: remainInLight, trackNumber: 6),
            Song(title: "Crosseyed and Painless", album: remainInLight, trackNumber: 2),
        ]
        let expected = [
            Song(title: "Born Under the Punches (The Heat Goes On)", album: remainInLight, trackNumber: 1),
            Song(title: "Crosseyed and Painless", album: remainInLight, trackNumber: 2),
            Song(title: "The Great Curve", album: remainInLight, trackNumber: 3),
            Song(title: "Once in a Lifetime", album: remainInLight, trackNumber: 4),
            Song(title: "House in Motion", album: remainInLight, trackNumber: 5),
            Song(title: "Seen and Not Seen", album: remainInLight, trackNumber: 6),
            Song(title: "Listening Wind", album: remainInLight, trackNumber: 7),
            Song(title: "The Overload", album: remainInLight, trackNumber: 8)
        ]
        
        // When
        let sorted = songs.sorted(by: \.trackNumber, order: .ascending)
        var sortedInPlace = songs
        sortedInPlace.sort(by: \.trackNumber, order: .ascending)
        
        // Then
        assertThat(sorted, areEqualTo: expected)
        assertThat(sortedInPlace, areEqualTo: expected)
    }
    
    func test_SongsWithSomeHavingArtistsDifferentThanAlbumsAndSomeNot_WhenSortingBySongArtistDescending_ReturnsSongsInCorrectOrder() {
        // Given
        let stopMakingSense = Album(
            title: "Stop Making Sense",
            artist: "Talking Heads",
            year: 1984
        )
        let randomAccessMemories = Album(
            title: "Random Access Memories",
            artist: "Daft Punk",
            year: 2013
        )
        let songs = [
            Song(title: "Burning Down the House", artist: nil, album: stopMakingSense, trackNumber: 6),
            Song(title: "Genius of Love", artist: "Tom Tom Club", album: stopMakingSense, trackNumber: 13),
            Song(title: "Beyond", artist: nil, album: randomAccessMemories, trackNumber: 9),
            Song(title: "Instant Crush", artist: "Daft Punk; Julian Casablancas", album: randomAccessMemories, trackNumber: 5),
            Song(title: "Take Me to the River", artist: nil, album: stopMakingSense, trackNumber: 15),
            Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5)
        ]
        let expected = [
            Song(title: "Burning Down the House", artist: nil, album: stopMakingSense, trackNumber: 6),
            Song(title: "Beyond", artist: nil, album: randomAccessMemories, trackNumber: 9),
            Song(title: "Take Me to the River", artist: nil, album: stopMakingSense, trackNumber: 15),
            Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5),
            Song(title: "Genius of Love", artist: "Tom Tom Club", album: stopMakingSense, trackNumber: 13),
            Song(title: "Instant Crush", artist: "Daft Punk; Julian Casablancas", album: randomAccessMemories, trackNumber: 5)
        ]
        
        // When
        let sorted = songs.sorted(by: \.artist, order: .descending)
        var sortedInPlace = songs
        sortedInPlace.sort(by: \.artist, order: .descending)
        
        // Then
        assertThat(sorted, areEqualTo: expected)
        assertThat(sortedInPlace, areEqualTo: expected)
    }
    
    // MARK: Sort a Sequence by Multiple Criteria
    
    func test_SongsFromDifferentAlbums_WhenSortingByAlbumArtistAscendingAndAlbumYearDescending_ReturnsSongsInCorrectOrder() {
        // Given
        let inflammableMaterial = Album(
            title: "Inflammable Material",
            artist: "Stiff Little Fingers",
            year: 1979
        )
        let pinkFlag = Album(
            title: "Pink Flag",
            artist: "Wire",
            year: 1977
        )
        let chairsMissing = Album(
            title: "Chairs Missing",
            artist: "Wire",
            year: 1978
        )
        let unknownPleasures = Album(
            title: "Unknown Pleasures",
            artist: "Joy Division",
            year: 1979
        )
        let songs = [
            Song(title: "Alternative Ulster", album: inflammableMaterial),
            Song(title: "12XU", album: pinkFlag),
            Song(title: "I Am the Fly", album: chairsMissing),
            Song(title: "Disorder", album: unknownPleasures)
        ]
        let expected = [
            Song(title: "Disorder", album: unknownPleasures),
            Song(title: "Alternative Ulster", album: inflammableMaterial),
            Song(title: "I Am the Fly", album: chairsMissing),
            Song(title: "12XU", album: pinkFlag)
        ]
        
        // When
        let sorted = songs.sorted(by: [
            SortCriterion(keyPath: \.album.artist, order: .ascending),
            SortCriterion(keyPath: \.album.year, order: .descending)
        ])
        var sortedInPlace = songs
        sortedInPlace.sort(by: [
            SortCriterion(keyPath: \.album.artist, order: .ascending),
            SortCriterion(keyPath: \.album.year, order: .descending)
        ])
        
        // Then
        assertThat(sorted, areEqualTo: expected)
        assertThat(sortedInPlace, areEqualTo: expected)
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
    let artist: String?
    let album: Album
    let trackNumber: Int?
    
    init(
        title: String,
        artist: String? = nil,
        album: Album,
        trackNumber: Int? = nil
    ) {
        self.title = title
        self.artist = artist
        self.album = album
        self.trackNumber = trackNumber
    }
}

// MARK: Equatable

extension Song: Equatable {}

// MARK: - Album

fileprivate struct Album {
    let title: String
    let artist: String
    let year: Int
}

// MARK: Equatable

extension Album: Equatable {}
