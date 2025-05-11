//
//  StockView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct StockView: View {
    @EnvironmentObject var teaDb: TeaDb
    @State private var showingAdd = false

    var body: some View {
        List {
            ForEach(TeaCategory.allCases, id: \.self) { teaType in
                let teas = teaDb.getBy(category: teaType)

                if !teas.isEmpty {
                    Section(header: Text("\(teaType.rawValue.capitalized) teas")) {
                        ForEach(teas) { tea in
                            VStack(alignment: .leading) {
                                Text(tea.name)
                                    .font(.headline)
                                
                                let unit = tea.teaType.rawValue.lowercased() == "loose" ? "grams" : "bags"
                                Text("Stock: \(tea.amountStocked) \(unit)")
                                Text("Remain")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Stock")
    }
}

#Preview {
    StockView().environmentObject(TeaDb())
}
