//
//  TeaListView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct TeaListView: View {
    @EnvironmentObject var teaDb: TeaDb
    
    @State var blackTeas: [TeaModel] = []
    @State var greenTeas: [TeaModel] = []
    @State var oolongTeas: [TeaModel] = []
    @State var whiteTeas: [TeaModel] = []
    @State var otherTeas: [TeaModel] = []
    
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
        }.onAppear(perform: initialiseLists)
    }
    
    func initialiseLists() {
        blackTeas = teaDb.getBy(type: .black)
        greenTeas = teaDb.getBy(type: .green)
        oolongTeas = teaDb.getBy(type: .oolong)
        whiteTeas = teaDb.getBy(type: .white)
        otherTeas = teaDb.getBy(type: .other)
    }
}

#Preview {
    TeaListView().environmentObject(TeaDb())
}
