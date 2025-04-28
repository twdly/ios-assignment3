//
//  TimerView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var teaDb: TeaDb
    
    @StateObject var tea: TeaModel
    
    @State var remainingTime: Int = -1
    @State var showTimer: Bool = false
    @State var timerMessage = ""
    @State var timer: Timer.TimerPublisher? = nil
    let dotSuffix: [String] = ["", ".", "..", "..."]
    
    var body: some View {
        VStack {
            Text(tea.name).font(.title)
            Spacer()

            if showTimer || remainingTime > 1 {
                Text("Remaining time: \(remainingTime/60):\(String(format: "%02d", remainingTime%60))").padding()
            } else {
                Text("Water temp: \(tea.waterTemp) ºC")
                Text("Water amount: \(tea.waterAmount) mL")
                Text("Time: \(tea.time) seconds")
                Button(action: beginTimer) {
                    Text("Begin").padding()
                }
            }
            Text(timerMessage)
            Spacer()
        }.onReceive(timer ?? Timer.publish(every: 1, on: .main, in: .common), perform: {_ in onTimer()})
            .onAppear(perform: initialiseTimer)
    }
    
    func beginTimer() {
        remainingTime = tea.time
        showTimer = true
        teaDb.timerDict[tea.id] = Date() // Initialise the dictionary with the current time so this view can be reinitialised if the user leaves
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer?.connect()
        timerMessage = "Steeping"
    }
    
    func onTimer() {
        if remainingTime != 0 {
            remainingTime -= 1
            timerMessage = "Steeping" + dotSuffix[(tea.time - remainingTime) % 4]
        } else {
            timerMessage = "Your tea is ready. Enjoy!"
            showTimer = false
            self.timer?.connect().cancel()
        }
    }
    
    func initialiseTimer() {
        guard let startTime = teaDb.timerDict[tea.id] else {
            // This timer is not currently running, do nothing
            return
        }
        
        let newTime = tea.time - Int(Date().timeIntervalSince(startTime))
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
}

#Preview {
    TimerView(tea: TeaDb().teas[4]).environmentObject(TeaDb())
}
