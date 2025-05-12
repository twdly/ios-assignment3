//
//  TimerViewModel.swift
//  assignment3
//
//  Created by Tai Woodley on 2/5/2025.
//

import Foundation
import UserNotifications

class TimerViewModel: ObservableObject {
    @Published var remainingTime: Int = -1
    @Published var startTime: Date? = nil
    @Published var showTimer: Bool = false
    @Published var timerMessage = ""
    @Published var timer: Timer.TimerPublisher? = nil
    
    let dotSuffix: [String] = ["", ".", "..", "..."]
    
    // Initialise the model by checking if a timer is currently running for the selected tea
    func initialiseTimer(tea: TeaModel, teaDb: TeaDb) {
        guard let dictStartTime = teaDb.timerDict[tea.id] else {
            // This timer is not currently running, do nothing
            return
        }
        
        startTime = dictStartTime
        let newTime = tea.time - Int(Date().timeIntervalSince(startTime!))
        guard newTime > 0 else {
            // Time has expired and is no longer needed
            teaDb.timerDict.removeValue(forKey: tea.id)
            return
        }
        
        remainingTime = newTime
        showTimer = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer?.connect()
        timerMessage = "Steeping"
    }
    
    // Begin the timer by updating the timer dictionary and scheduling a notification
    func beginTimer(tea: TeaModel, teaDb: TeaDb) {
        startTime = Date()
        remainingTime = tea.time
        showTimer = true
        teaDb.timerDict[tea.id] = Date() // Initialise the dictionary with the current time so this view can be reinitialised if the user leaves
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer?.connect()
        timerMessage = "Steeping"
        schedulateNotification(tea: tea)
        teaDb.brewTea(id: tea.id)
    }
    
    // Function that runs every second, updates the timer value and "animates" the dots after the "steeping" message
    func onTimer(tea: TeaModel) {
        if remainingTime > 0 {
            remainingTime = tea.time - Int(Date().timeIntervalSince(startTime!))
            timerMessage = "Steeping" + dotSuffix[(tea.time - remainingTime) % 4]
        } else {
            timerMessage = "Your tea is ready. Enjoy!"
            showTimer = false
            self.timer?.connect().cancel()
        }
    }
    
    // Schedules a notification to be sent when the timer has elapsed
    func schedulateNotification(tea: TeaModel) {
        let notifContent = UNMutableNotificationContent()
        notifContent.title = "Tea time!"
        notifContent.body = "Your \(tea.name) is ready!"
        notifContent.sound = .defaultRingtone
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(tea.time), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notifContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Returns the time as a string in the format m:ss to display nicely
    func getFormattedTime() -> String{
        return "\(remainingTime / 60):\(String(format: "%02d", remainingTime % 60))"
    }
}
