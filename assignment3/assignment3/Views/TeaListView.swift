//
//  TeaListView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct TeaListView: View {
    @EnvironmentObject var teaDb: TeaDb
    
    var body: some View {
        NavigationStack {
            List(TeaType.allCases, id: \.hashValue) { teaType in
                if !teaDb.getBy(type: teaType).isEmpty {
                    Section(header: Text(teaType.rawValue)) {
                        ForEach(teaDb.getBy(type: teaType)) { tea in
                            NavigationLink {
                                TimerView(tea: tea)
                            } label: {
                                Text(tea.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My teas")
            .overlay(content: {
                if teaDb.teas.count == 0 {
                    Text("No teas could be found")
                }
            })
        }
    }
}

#Preview {
    TeaListView().environmentObject(TeaDb())
}
