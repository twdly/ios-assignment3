//
//  TimerListViewModel.swift
//  assignment3
//
//  Created by Tai Woodley on 6/5/2025.
//

import Foundation

class TimerListViewModel: ObservableObject {
    @Published var timers: [TeaTimerModel]
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        self.timers = []
    }
    
    func initialiseTimers(db teaDb: TeaDb) {
        timers = []
        for timer in teaDb.timerDict {
            guard let tea = teaDb.getBy(id: timer.key) else {
                continue
            }
            
            let remainingTime = tea.time - Int(Date().timeIntervalSince(timer.value))
            timers.append(TeaTimerModel(id: timer.key, name: tea.name, remainingTime: remainingTime))
        }
    }
    
    func update() {
        for timerModel in timers {
            timerModel.remainingTime -= 1
            if timerModel.remainingTime == 0 {
                timers.removeAll(where: {$0.id == timerModel.id})
            }
        }
    }
}
