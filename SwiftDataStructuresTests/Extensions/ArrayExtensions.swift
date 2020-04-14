//
//  ArrayExtensions.swift
//  SwiftDataStructuresTests
//
//  Created by Marc-Antoine Malépart on 2020-04-14.
//  Copyright © 2020 OffTheMark. All rights reserved.
//

import Foundation

extension Array where Element == String {
    /// Returns a new string by concatenating the non-empty elements of the sequence, adding the given separator between each non-empty element.
    ///
    /// - Parameter separator: A string to insert between each of the non-empty elements in this sequence. The default separator is an empty string.
    ///
    /// - Returns: A single, concatenated string.
    func nonEmptyJoined(separator: String = "") -> String {
        return self
            .filter({ !$0.isEmpty })
            .joined(separator: separator)
    }
}
