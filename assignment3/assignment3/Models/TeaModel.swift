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
    let url: String?
    
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
