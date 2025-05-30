//
//  TeaModel.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import Foundation

struct TeaModel: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let category: TeaCategory
    let teaType: TeaType
    let waterAmount: Int
    let waterTemp: Int
    let time: Int
    let url: String?
    let teaUsedPerBrew: Int
    var amountStocked: Int
}

