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
<<<<<<< HEAD
    let teaUsedPerBrew: Int
    var amountStocked: Int
=======
    
    init(id: Int, name: String, type: TeaType, waterAmount: Int, waterTemp: Int, time: Int, url: String?) {
        self.id = id
        self.name = name
        self.type = type
        self.waterAmount = waterAmount
        self.waterTemp = waterTemp
        self.time = time
        self.url = url
    }
}

/// SwiftUI must know which TeaModel you want to navigate via comparing id
extension TeaModel: Hashable {
    // Compare two TeaModels by id to check equality
    static func == (lhs: TeaModel, rhs: TeaModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Generate hash value using id
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
>>>>>>> 26ac14282970e955ea69c0c2e9e810f2888d95b8
}
