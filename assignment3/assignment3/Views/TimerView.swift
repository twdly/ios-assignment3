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
        Text(tea.name)
    }
}

#Preview {
    TimerView(tea: TeaDb().teas[0])
}
