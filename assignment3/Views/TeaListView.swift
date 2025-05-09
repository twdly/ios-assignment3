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
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        delete(tea: tea)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
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
                                showingAdd.toggle()
                            } label: {
                                Image(systemName: "plus")
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

/*private func delete(tea: TeaModel) {
        teaDb.objectWillChange.send()
        teaDb.teas.removeAll { $0.id == tea.id }
    }*/


#Preview {
    TeaListView()
        .environmentObject(TeaDb())
}
