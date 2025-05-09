//
//  TimerView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    @EnvironmentObject var teaDb: TeaDb
    
    @StateObject var tea: TeaModel
    @StateObject var timerViewModel: TimerViewModel = TimerViewModel()
    
    var body: some View {
        VStack {
            Spacer()

            if timerViewModel.showTimer || timerViewModel.remainingTime > 1 {
                Text("Remaining time: \(timerViewModel.getFormattedTime())").padding()
            } else {
                Text("Water temp: \(tea.waterTemp) ºC")
                Text("Water amount: \(tea.waterAmount) mL")
                Text("Time: \(tea.time) seconds")
                Button(action: { timerViewModel.beginTimer(tea: tea, teaDb: teaDb) }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                        Text("Begin")
                    }.padding()
                }
            }
            Text(timerViewModel.timerMessage)
            NavigationLink {
                WriteReviewView(tea: tea)
            } label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("Write review")
                }
            }.padding()
            Spacer()
        }.onReceive(timerViewModel.timer ?? Timer.publish(every: 1, on: .main, in: .common), perform: {_ in timerViewModel.onTimer(tea: tea)})
            .onAppear(perform: { timerViewModel.initialiseTimer(tea: tea, teaDb: teaDb) })
            .toolbar {
                NavigationLink {
                    EditTeaView(originalTea:tea).environmentObject(teaDb)
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            .navigationTitle(tea.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let tea = TeaModel(id: 0, name: "Test", type: .oolong, waterAmount: 92, waterTemp: 92, time: 5, url: "https://example.com")
    TimerView(tea: tea).environmentObject(TeaDb())
}
