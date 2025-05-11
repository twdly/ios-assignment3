//
//  TeaModel.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import Foundation

class TeaModel: Identifiable, ObservableObject {
    let id: Int
    @Published var name: String
    @Published var type: TeaType
    @Published var waterAmount: Int
    @Published var waterTemp: Int
    @Published var time: Int
    @Published var url: String?
    
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
