//
//  TimerListView.swift
//  assignment3
//
//  Created by Tai Woodley on 6/5/2025.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var teaDb: TeaDb
    
    // timers need to be calculated from the environment object above
    @StateObject var timersViewModel: TimerListViewModel = TimerListViewModel()
    
    var body: some View {
        NavigationStack {
            if timersViewModel.timers.isEmpty {
                Text("No timers are currently running")
            } else {
                List {
                    ForEach(timersViewModel.timers) { timer in
                        TimerListRow(timer: timer)
                    }
                }
                .id(UUID()) // No clue why but this ID fixes the list not being updated properly
                .navigationTitle("Timers")
            }
        }
        .onAppear(perform: { timersViewModel.initialiseTimers(db: teaDb) })
        .onReceive(timersViewModel.timer, perform: { _ in timersViewModel.update() })
    }
}

#Preview {
    ContentView()
}
