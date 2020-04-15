//
//  SortCriterionAreInIncreasingOrderTests.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-15.
//

import XCTest
@testable import SwiftDataStructures

final class SortCriterionAreInIncreasingOrderTests: XCTestCase {
    // MARK: Checking if Two Elements Are in Ascending Order Based on a Keypath with a Non-Optional Value

    func test_GivenCriterionComparingSongsByTitleCountAscending_WhenComparingSongWithShorterTitleToSongWithLongerTitle_ReturnsTrue() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.title.count, order: .ascending)
        let album = Album(title: "Humbug", artist: "Arctic Monkeys", year: 2009)
        let first = Song(title: "Cornerstone", album: album, trackNumber: 7)
        let second = Song(title: "Dance Little Liar", album: album, trackNumber: 8)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        XCTAssertTrue(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTitleCountAscending_WhenComparingTwoSongsWithSameLength_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.title.count, order: .ascending)
        let album = Album(title: "Humbug", artist: "Arctic Monkeys", year: 2009)
        let first = Song(title: "Dangerous Animals", album: album, trackNumber: 3)
        let second = Song(title: "Dance Little Liar", album: album, trackNumber: 8)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTitleCountAscending_WhenComparingSongWithLongerTitleToSongWithShorterTitle_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.title.count, order: .ascending)
        let album = Album(title: "Humbug", artist: "Arctic Monkeys", year: 2009)
        let first = Song(title: "Dance Little Liar", album: album, trackNumber: 8)
        let second = Song(title: "Cornerstone", album: album, trackNumber: 7)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTitleCountDescending_WhenComparingSongWithShorterTitleToSongWithLongerTitle_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.title.count, order: .descending)
        let album = Album(title: "Humbug", artist: "Arctic Monkeys", year: 2009)
        let first = Song(title: "Cornerstone", album: album, trackNumber: 7)
        let second = Song(title: "Dance Little Liar", album: album, trackNumber: 8)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTitleCountDescending_WhenComparingTwoSongsWithSameLength_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.title.count, order: .descending)
        let album = Album(title: "Humbug", artist: "Arctic Monkeys", year: 2009)
        let first = Song(title: "Dangerous Animals", album: album, trackNumber: 3)
        let second = Song(title: "Dance Little Liar", album: album, trackNumber: 8)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTitleCountDescending_WhenComparingSongWithLongerTitleToSongWithShorterTitle_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.title.count, order: .descending)
        let album = Album(title: "Humbug", artist: "Arctic Monkeys", year: 2009)
        let first = Song(title: "Dance Little Liar", album: album, trackNumber: 8)
        let second = Song(title: "Cornerstone", album: album, trackNumber: 7)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertTrue(areInIncreasingOrder)
    }
    
    // MARK: Checking if Two Elements Are in Ascending Order Based on a Keypath with an Optional Value
    
    func test_GivenCriterionComparingSongsByTrackNumberAscending_WhenComparingSongWithTrackNumberToSongWithGreaterTrackNumber_ReturnsTrue() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.trackNumber, order: .ascending)
        let album = Album(title: "Hot Thoughts", artist: "Spoon", year: 2017)
        let first = Song(title: "Hot Thoughts", album: album, trackNumber: 1)
        let second = Song(title: "Can I Sit Next to You", album: album, trackNumber: 6)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertTrue(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTrackNumberAscending_WhenComparingTwoSongsWithSameTrackNumber_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.trackNumber, order: .ascending)
        let turnOnTheBrightLights = Album(title: "Turn On the Bright Lights", artist: "Interpol", year: 2002)
        let marauder = Album(title: "Marauder", artist: "Interpol", year: 2018)
        let first = Song(title: "Untitled", album: turnOnTheBrightLights, trackNumber: 1)
        let second = Song(title: "If You Really Love Nothing", album: marauder, trackNumber: 1)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTrackNumberAscending_WhenComparingSongWithTrackNumberToSongWithLesserTrackNumber_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.trackNumber, order: .ascending)
        let album = Album(title: "Hot Thoughts", artist: "Spoon", year: 2017)
        let first = Song(title: "Can I Sit Next to You", album: album, trackNumber: 6)
        let second = Song(title: "Hot Thoughts", album: album, trackNumber: 1)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByArtistAscending_WhenComparingSongWithArtistToSongWithoutArtist_ReturnsTrue() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.artist, order: .ascending)
        let stopMakingSense = Album(title: "Stop Making Sense", artist: "Talking Heads", year: 1984
        )
        let first = Song(title: "Genius of Love", artist: "Tom Tom Club", album: stopMakingSense, trackNumber: 13)
        let second = Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertTrue(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByArtistAscending_WhenComparingSongWithoutArtistToSongWithArtist_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.artist, order: .ascending)
        let stopMakingSense = Album(title: "Stop Making Sense", artist: "Talking Heads", year: 1984)
        let first = Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5)
        let second = Song(title: "Genius of Love", artist: "Tom Tom Club", album: stopMakingSense, trackNumber: 13)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByArtistAscending_WhenComparingSongWithoutArtistToOtherSongWithoutArtist_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.artist, order: .ascending)
        let stopMakingSense = Album(title: "Stop Making Sense", artist: "Talking Heads", year: 1984)
        let first = Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5)
        let second = Song(title: "Take Me to the River", artist: nil, album: stopMakingSense, trackNumber: 15)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTrackNumberDescending_WhenComparingSongWithTrackNumberToSongWithGreaterTrackNumber_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.trackNumber, order: .descending)
        let album = Album(title: "Hot Thoughts", artist: "Spoon", year: 2017)
        let first = Song(title: "Hot Thoughts", album: album, trackNumber: 1)
        let second = Song(title: "Can I Sit Next to You", album: album, trackNumber: 6)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTrackNumberDescending_WhenComparingTwoSongsWithSameTrackNumber_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.trackNumber, order: .descending)
        let turnOnTheBrightLights = Album(title: "Turn On the Bright Lights", artist: "Interpol", year: 2002)
        let marauder = Album(title: "Marauder", artist: "Interpol", year: 2018)
        let first = Song(title: "Untitled", album: turnOnTheBrightLights, trackNumber: 1)
        let second = Song(title: "If You Really Love Nothing", album: marauder, trackNumber: 1)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByTrackNumberDescending_WhenComparingSongWithTrackNumberToSongWithLesserTrackNumber_ReturnsTrue() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.trackNumber, order: .descending)
        let album = Album(title: "Hot Thoughts", artist: "Spoon", year: 2017)
        let first = Song(title: "Can I Sit Next to You", album: album, trackNumber: 6)
        let second = Song(title: "Hot Thoughts", album: album, trackNumber: 1)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertTrue(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByArtistDescending_WhenComparingSongWithArtistToSongWithoutArtist_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.artist, order: .descending)
        let stopMakingSense = Album(title: "Stop Making Sense", artist: "Talking Heads", year: 1984
        )
        let first = Song(title: "Genius of Love", artist: "Tom Tom Club", album: stopMakingSense, trackNumber: 13)
        let second = Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByArtistDescending_WhenComparingSongWithoutArtistToSongWithArtist_ReturnsTrue() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.artist, order: .descending)
        let stopMakingSense = Album(title: "Stop Making Sense", artist: "Talking Heads", year: 1984)
        let first = Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5)
        let second = Song(title: "Genius of Love", artist: "Tom Tom Club", album: stopMakingSense, trackNumber: 13)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertTrue(areInIncreasingOrder)
    }
    
    func test_GivenCriterionComparingSongsByArtistDescending_WhenComparingSongWithoutArtistToOtherSongWithoutArtist_ReturnsFalse() {
        // Given
        let criterion = SortCriterion(keyPath: \Song.artist, order: .descending)
        let stopMakingSense = Album(title: "Stop Making Sense", artist: "Talking Heads", year: 1984)
        let first = Song(title: "Slippery People", artist: nil, album: stopMakingSense, trackNumber: 5)
        let second = Song(title: "Take Me to the River", artist: nil, album: stopMakingSense, trackNumber: 15)
        
        // When
        let areInIncreasingOrder = criterion.areInIncreasingOrder(first, second)
        
        // Then
        XCTAssertFalse(areInIncreasingOrder)
    }
}
