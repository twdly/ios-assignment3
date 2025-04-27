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
                Section(header: Text("Black teas")) {
                    
                }
                Section(header: Text("Green teas")) {
                    
                }
                Section(header: Text("Oolong teas")) {
                    
                }
                Section(header: Text("White teas")) {
                    
                }
                Section(header: Text("Other")) {
                    
                }
            }
        }.navigationTitle(Text("My teas")).onAppear(perform: initialiseLists)
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
