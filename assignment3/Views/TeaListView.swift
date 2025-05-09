//
//  TeaListView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

//
//  TeaListView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct TeaListView: View {
    @EnvironmentObject var teaDb: TeaDb
    @State private var showingAdd = false
    var body: some View {
        NavigationStack {
            List(TeaType.allCases, id: \.hashValue) { teaType in
                if !teaDb.getBy(type: teaType).isEmpty {
                    Section(header: Text("\(teaType.rawValue) teas")) {
                        ForEach(teaDb.getBy(type: teaType)) { tea in
                            TeaListRowView(tea: tea).swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive, action: { delete(tea: tea) }) {
                                    Label("Delete", systemImage: "trash")
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
            .overlay(content: {
                if teaDb.teas.count == 0 {
                    Text("No teas could be found")
                }
            })
        }
    }
    
    func delete(tea: TeaModel) {
        teaDb.objectWillChange.send()
        teaDb.teas.removeAll { $0.id == tea.id }
    }
}

#Preview {
    TeaListView().environmentObject(TeaDb())
}
