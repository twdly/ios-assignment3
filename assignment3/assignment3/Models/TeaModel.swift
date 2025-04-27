//
//  TeaModel.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import Foundation

class TeaModel: Identifiable, Codable {
    let id: Int
    let name: String
    let type: TeaType
    let waterAmount: Int
    let waterTemp: Int
    let time: Int
    
    init(id: Int, name: String, type: TeaType, waterAmount: Int, waterTemp: Int, time: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.waterAmount = waterAmount
        self.waterTemp = waterTemp
        self.time = time
    }
}
