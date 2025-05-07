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
    @State private var showingEditList = false
    @State private var editingTea: TeaModel? = nil
    
    var body: some View {
        NavigationStack {
            List(TeaType.allCases, id: \.hashValue) { teaType in
                if !teaDb.getBy(type: teaType).isEmpty {
                    Section(header: Text("\(teaType.rawValue) teas")) {
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
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAdd.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
                    .confirmationDialog("What would you like to do?", isPresented: $showMenu, titleVisibility: .visible) {
                            Button("Add Tea") { showingAdd = true }
                            Button("Edit Tea") { showingEditList = true }
                            Button("Cancel", role: .cancel) {}
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddTeaView()
                .environmentObject(teaDb)
            }
            .sheet(isPresented: $showingEditList) {
                            NavigationStack {
                                List(teaDb.teas) { tea in
                                    Button(tea.name) {
                                        editingTea = tea
                                        showingEditList = false
                                    }
                                }
                                .navigationTitle("Select Tea to Edit")
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Cancel") {
                                            showingEditList = false
                                        }
                                    }
                                }
                            }
                            .environmentObject(teaDb)
                        }
                        .sheet(item: $editingTea) { tea in
                            EditTeaView(tea: tea)
                                .environmentObject(teaDb)
                        }
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
