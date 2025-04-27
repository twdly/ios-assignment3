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
            List {
                if !blackTeas.isEmpty {
                    Section(header: Text("Black teas")) {
                        ForEach(blackTeas) { tea in
                            Text(tea.name)
                        }
                    }
                }
                if !greenTeas.isEmpty {
                    Section(header: Text("Green teas")) {
                        ForEach(greenTeas) { tea in
                            Text(tea.name)
                        }
                    }
                }
                if !oolongTeas.isEmpty {
                    Section(header: Text("Oolong teas")) {
                        ForEach(oolongTeas) { tea in
                            Text(tea.name)
                        }
                    }
                }
                if !whiteTeas.isEmpty {
                    Section(header: Text("White teas")) {
                        ForEach(whiteTeas) { tea in
                            Text(tea.name)
                        }
                    }
                }
                if !otherTeas.isEmpty {
                    Section(header: Text("Other")) {
                        ForEach(otherTeas) { tea in
                            Text(tea.name)
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
