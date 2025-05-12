//
//  TeaType.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import Foundation

// Enum representing the category of tea for filtering and list sections
enum TeaCategory: String, Codable, CaseIterable {
    case black
    case green
    case white
    case oolong
    case other
}
