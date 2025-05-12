//
//  TeaListRowView.swift
//  assignment3
//
//  Created by Delbert Charlie on 9/5/2025.
//

import SwiftUI

struct TeaListRowView: View {
    let tea: TeaModel
    var body: some View {
        NavigationLink {
            TimerView(tea: tea)
        } label: {
            Text(tea.name)
        }
    }
}

#Preview {
    TeaListRowView(tea: TeaDb().teas[0])
}
