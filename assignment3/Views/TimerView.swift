//
//  TimerView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct TimerView: View {
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
    }
    
    func beginTimer() {
        remainingTime = tea.time
        showTimer = true
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
}

#Preview {
    TimerView(tea: TeaDb().teas[4])
}
