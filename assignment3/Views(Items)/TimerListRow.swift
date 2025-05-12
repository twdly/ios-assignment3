//
//  TimerListRow.swift
//  assignment3
//
//  Created by Tai Woodley on 6/5/2025.
//

import SwiftUI

struct TimerListRow: View {
    @StateObject var timer: TeaTimerModel
    
    var body: some View {
        Text("\(timer.name) - \(timer.getFormattedTime())")
    }
}

#Preview {
    TimerListRow(timer: TeaTimerModel(id: 0, name: "Tea", remainingTime: 92))
}
