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
    let startingTime: Date
    let steepingTime: Int
    @Published var remainingTime: Int
    
    init(id: Int, name: String, startingTime: Date, steepingTime: Int, remainingTime: Int) {
        self.id = id
        self.name = name
        self.startingTime = startingTime
        self.steepingTime = steepingTime
        self.remainingTime = remainingTime
    }
    
    //return remaining time as a string for displaying
    func getFormattedTime() -> String{
        return "\(remainingTime / 60):\(String(format: "%02d", remainingTime % 60))"
    }
}
