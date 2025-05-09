//
//  TeaListView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct TeaListView: View {
    @EnvironmentObject var teaDb: TeaDb
    @State private var showMenu = false
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(TeaType.allCases, id: \.self) { teaType in
                    let teasOfType = teaDb.getBy(type: teaType)
                    if !teasOfType.isEmpty {
                        Section(header: Text("\(teaType.rawValue.capitalized) Teas")) {
                            ForEach(teasOfType) { tea in
                                NavigationLink {
                                    TimerView(tea: tea)
                                } label: {
                                    Text(tea.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Teas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showMenu = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                    .confirmationDialog("Manage Teas", isPresented: $showMenu, titleVisibility: .visible) {
                        Button("Add New Tea") { showingAdd = true }
                        Button("Edit Existing Tea") { showingEditList = true }
                        Button("Cancel", role: .cancel) {}
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddTeaView()
                    .environmentObject(teaDb)
            }
            .overlay {
                if teaDb.teas.isEmpty {
                    Text("No teas could be found")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    TeaListView()
        .environmentObject(TeaDb())
}
