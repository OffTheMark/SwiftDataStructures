//
//  Song.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

// MARK: Song

struct Song {
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

struct Album {
    let title: String
    let artist: String
    let year: Int
}

// MARK: Equatable

extension Album: Equatable {}
