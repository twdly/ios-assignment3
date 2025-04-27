//
//  TimerView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct TimerView: View {
    @StateObject var tea: TeaModel
    var body: some View {
        VStack {
            Text(tea.name).font(.title)
            Spacer()
            Text("Water temp: \(tea.waterTemp) ºC")
            Text("Water amount: \(tea.waterAmount) mL")
            Text("Time: \(tea.time) seconds")
            Spacer()
        }

    }
}

#Preview {
    TimerView(tea: TeaDb().teas[0])
}
