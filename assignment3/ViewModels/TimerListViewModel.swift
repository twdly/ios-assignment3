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
        for timer in teaDb.timerDict {
            guard let tea = teaDb.getBy(id: timer.key) else {
                continue
            }
            
            guard !timers.contains(where: {$0.id == tea.id}) else {
                timers.first(where: {$0.id == tea.id})?.remainingTime = tea.time - Int(Date().timeIntervalSince(timer.value))
                continue
            }
            
            let remainingTime = tea.time - Int(Date().timeIntervalSince(timer.value))
            if remainingTime > 0 {
                timers.append(TeaTimerModel(id: timer.key, name: tea.name, startingTime: timer.value, steepingTime: tea.time, remainingTime: remainingTime))
            }
        }
    }
    
    func update() {
        for timerModel in timers {
            timerModel.remainingTime = timerModel.steepingTime - Int(Date().timeIntervalSince(timerModel.startingTime))
        }
        timers.removeAll(where: {$0.remainingTime <= 0})
    }
}
