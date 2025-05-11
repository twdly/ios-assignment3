//
//  ReviewModel.swift
//  assignment3
//
//  Created by Tai Woodley on 1/5/2025.
//

import Foundation

struct ReviewModel: Identifiable, Codable {
    var id: Int
    var teaName: String
    var rating: Int
    var message: String
    var url: String
}
