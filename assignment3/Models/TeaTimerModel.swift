//
//  TeaTimerModel.swift
//  assignment3
//
//  Created by Tai Woodley on 6/5/2025.
//

import Foundation

class TeaTimerModel: Identifiable, ObservableObject {
    let id: Int
    let name: String
    @Published var remainingTime: Int
    
    init(id: Int, name: String, remainingTime: Int) {
        self.id = id
        self.name = name
        self.remainingTime = remainingTime
    }
    
    func getFormattedTime() -> String{
        return "\(remainingTime / 60):\(String(format: "%02d", remainingTime % 60))"
    }
}
