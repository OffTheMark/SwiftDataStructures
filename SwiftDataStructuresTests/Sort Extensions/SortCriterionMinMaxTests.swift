//
//  SortCriterionMinMaxTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import XCTest
@testable import SwiftDataStructures

final class SortCriterionMinMaxTests: XCTestCase {
    // MARK: Finding the Minimum and Maximum by a Key Path with Non-Optional Value
    
    func test_EmptySongs_WhenGettingMinByTitleCountAscending_ReturnsNil() {
        // Given
        let songs = [Song]()
        
        // When
        let minimum = songs.min(by: \.title.count, order: .ascending)
        let maximum = songs.max(by: \.title.count, order: .descending)
        
        // Then
        XCTAssertNil(minimum)
        XCTAssertNil(maximum)
    }
    
    func test_Songs_WhenGettingMaxByTitleCountAscending_ReturnsSameSong() {
        // Given
        let remainInLight = Album(title: "Remain in Light", artist: "Talking Heads", year: 1980)
        let songs = [
            Song(title: "Born Under the Punches (The Heat Goes On)", album: remainInLight, trackNumber: 1),
            Song(title: "Crosseyed and Painless", album: remainInLight, trackNumber: 2),
            Song(title: "The Great Curve", album: remainInLight, trackNumber: 3),
            Song(title: "Once in a Lifetime", album: remainInLight, trackNumber: 4),
            Song(title: "House in Motion", album: remainInLight, trackNumber: 5),
            Song(title: "Seen and Not Seen", album: remainInLight, trackNumber: 6),
            Song(title: "Listening Wind", album: remainInLight, trackNumber: 7),
            Song(title: "The Overload", album: remainInLight, trackNumber: 8)
        ]
        let expected = Song(title: "Born Under the Punches (The Heat Goes On)", album: remainInLight, trackNumber: 1)
        
        // When
        let minimum = songs.min(by: \.title.count, order: .descending)
        let maximum = songs.max(by: \.title.count, order: .ascending)
        
        // Then
        XCTAssertEqual(minimum, expected)
        XCTAssertEqual(maximum, expected)
    }
    
    // MARK: Finding the Minimum and Maximum by a Key Path with Optional Value
    
    func test_EmptySongs_WhenGettingMaxByTrackNumberAscending_ReturnsNil() {
        // Given
        let songs = [Song]()
        
        // When
        let minimum = songs.min(by: \.trackNumber, order: .descending)
        let maximum = songs.max(by: \.trackNumber, order: .ascending)
        
        // Then
        XCTAssertNil(minimum)
        XCTAssertNil(maximum)
    }
    
    func test_SongsWithSomeHavingTrackNumberAndSomeNot_WhenGettingMaxByTrackNumberAscending_ReturnsSameSongHavingNoTrackNumber() {
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
            Song(title: "Burning Down the House", album: stopMakingSense, trackNumber: 6),
            Song(title: "Genius of Love", album: stopMakingSense, trackNumber: 13),
            Song(title: "Beyond", album: randomAccessMemories, trackNumber: nil),
            Song(title: "Instant Crush", album: randomAccessMemories, trackNumber: nil),
            Song(title: "Take Me to the River", album: stopMakingSense, trackNumber: 15),
            Song(title: "Slippery People", album: stopMakingSense, trackNumber: 5)
        ]
        let expected = Song(title: "Beyond", album: randomAccessMemories, trackNumber: nil)
        
        // When
        let minimum = songs.min(by: \.trackNumber, order: .descending)
        let maximum = songs.max(by: \.trackNumber, order: .ascending)
        
        // Then
        XCTAssertEqual(minimum, expected)
        XCTAssertEqual(maximum, expected)
    }
    
    func test_SongsWithSomeHavingTrackNumberAndSomeNot_WhenGettingMinByTrackNumberAscending_ReturnsSameSongHavingTrackNumber() {
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
            Song(title: "Burning Down the House", album: stopMakingSense, trackNumber: 6),
            Song(title: "Genius of Love", album: stopMakingSense, trackNumber: 13),
            Song(title: "Beyond", album: randomAccessMemories, trackNumber: nil),
            Song(title: "Instant Crush", album: randomAccessMemories, trackNumber: nil),
            Song(title: "Take Me to the River", album: stopMakingSense, trackNumber: 15),
            Song(title: "Slippery People", album: stopMakingSense, trackNumber: 5)
        ]
        let expected = Song(title: "Slippery People", album: stopMakingSense, trackNumber: 5)
        
        // When
        let minimum = songs.min(by: \.trackNumber, order: .ascending)
        let maximum = songs.max(by: \.trackNumber, order: .descending)
        
        // Then
        XCTAssertEqual(minimum, expected)
        XCTAssertEqual(maximum, expected)
    }
    
    // MARK: Finding the Minimum and Maximum by Criteria
    
    func test_SongsWithSomeHavingArtistAndSomeNot_WhenGettingMinByAlbumYearAscendingAndArtistAscending_ReturnsExpectedSong() {
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
        let expected = Song(title: "Genius of Love", artist: "Tom Tom Club", album: stopMakingSense, trackNumber: 13)
        
        // Given
        let minimum = songs.min(by: [
            SortCriterion(keyPath: \.album.year, order: .ascending),
            SortCriterion(keyPath: \.artist, order: .ascending)
        ])
        let maximum = songs.max(by: [
            SortCriterion(keyPath: \.album.year, order: .descending),
            SortCriterion(keyPath: \.artist, order: .descending)
        ])
        
        XCTAssertEqual(minimum, expected)
        XCTAssertEqual(maximum, expected)
    }
}
