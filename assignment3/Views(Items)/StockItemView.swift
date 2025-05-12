//
//  TeaStockItem.swift
//  assignment3
//
//  Created by Griffin Frame-Szafjanski on 12/5/2025.
//

import SwiftUI

struct StockItemView: View {
    let tea: TeaModel
    let isEditing: Bool
    let tempStock: Int
    let onEditToggle: () -> Void
    let onStockChange: (Int) -> Void
    let onSave: () -> Void

    // This is the code for a single tea in the stock list, it has a label shows current stock and allows the editing of the stock
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(tea.name)
                .font(.headline)

            let unit = tea.teaType == .Loose ? "grams" : "bags"
            Text("Stock: \(tea.amountStocked) \(unit)")

            //this buttin toggles showing editing panel for current tea
            Button(isEditing ? "Close" : "Edit stock", action: onEditToggle)

            if isEditing {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Enter new stock", value: Binding(
                        get: { tempStock },
                        set: { onStockChange($0) }
                    ), format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)

                    Button("Save", action: onSave)
                }
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 4)
    }
}
