//
//  StockView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct StockView: View {
    @EnvironmentObject var teaDb: TeaDb
    @StateObject private var viewModel = StockViewModel()

    //this just lists all the teas (StockItemView )
    var body: some View {
        NavigationStack {
            List {
                ForEach(TeaCategory.allCases, id: \.self) { teaType in
                    let teas = viewModel.teas(for: teaType, using: teaDb)
                    if !teas.isEmpty {
                        Section(header: Text("\(teaType.rawValue.capitalized) teas")) {
                            ForEach(teas) { tea in
                                StockItemView(
                                    tea: tea,
                                    isEditing: viewModel.isEditing(tea),
                                    tempStock: viewModel.tempStockValues[tea.id] ?? tea.amountStocked,
                                    onEditToggle: {
                                        viewModel.toggleEditing(for: tea)
                                    },
                                    onStockChange: { newValue in
                                        viewModel.updateTempStock(for: tea, to: newValue)
                                    },
                                    onSave: {
                                        viewModel.saveStock(for: tea, using: teaDb)
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Stock")
        }
    }
}
