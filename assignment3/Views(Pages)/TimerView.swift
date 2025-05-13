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
    
    var tea: TeaModel
    @StateObject var timerViewModel: TimerViewModel = TimerViewModel()
    
    var body: some View {
        VStack {
            Spacer()

            if timerViewModel.showTimer || timerViewModel.remainingTime > 1 {
                InfoPanelView(title: "Remaining time",textColor: nil, imageName: "cup.and.saucer", details: timerViewModel.getFormattedTime(), width: 180)
            } else {
                HStack {
                    InfoPanelView(title: "Water temp.", textColor: nil, imageName: "thermometer", details: "\(tea.waterTemp)ºC", width: 140)
                    InfoPanelView(title: "Water amount", textColor: nil, imageName: "drop", details: "\(tea.waterAmount) mL", width: 140)
                }
                HStack {
                    InfoPanelView(title: "Time",textColor: nil, imageName: "clock", details: "\(tea.time) seconds", width: 140)
                    InfoPanelView(
                        title: "Tea Amount", textColor: nil,
                        imageName: "scalemass",
                        details: "\(tea.teaUsedPerBrew) \(tea.teaType == .Loose ? "Grams" : "Bags")",
                        width: 140
                    )
                }
                if (teaDb.calculateRemainingCups(tea) < 5){
                    InfoPanelView(title: "Remaining", textColor: .red, imageName: "mug.fill", details: "\(teaDb.calculateRemainingCups(tea)) Cups", width:320)
                }else{
                    InfoPanelView(title: "Remaining", textColor: nil, imageName: "mug.fill", details: "\(teaDb.calculateRemainingCups(tea)) Cups", width:320)
                }
               
                Button(action: { timerViewModel.beginTimer(tea: tea, teaDb: teaDb) }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                        Text("Begin")
                    }.padding()
                }
                NavigationLink {
                    WriteReviewView(tea: tea)
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Write review")
                    }
                }.padding()
            }
            Text(timerViewModel.timerMessage).padding()
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
    let tea = TeaModel(id: 0, name: "Test", category: .oolong, teaType: .Loose, waterAmount: 92, waterTemp: 92, time: 5, url: "https://example.com", teaUsedPerBrew: 5, amountStocked: 200 )
    TimerView(tea: tea).environmentObject(TeaDb())
}
