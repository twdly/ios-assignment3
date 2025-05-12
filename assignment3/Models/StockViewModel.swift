//
//  StockViewModel.swift
//  assignment3
//
//  Created by Griffin Frame-Szafjanski on 12/5/2025.
//


import Foundation

class StockViewModel: ObservableObject {
    @Published var editingTeas: Set<Int> = []
    @Published var tempStockValues: [Int: Int] = [:]

    init() {}

    func teas(for category: TeaCategory, using teaDb: TeaDb) -> [TeaModel] {
        return teaDb.getBy(category: category)
    }

    func isEditing(_ tea: TeaModel) -> Bool {
        editingTeas.contains(tea.id)
    }

    func toggleEditing(for tea: TeaModel) {
        if editingTeas.contains(tea.id) {
            editingTeas.remove(tea.id)
        } else {
            editingTeas.insert(tea.id)
            tempStockValues[tea.id] = tea.amountStocked
        }
    }

    func updateTempStock(for tea: TeaModel, to value: Int) {
        tempStockValues[tea.id] = value
    }

    func saveStock(for tea: TeaModel, using teaDb: TeaDb) {
        if let newValue = tempStockValues[tea.id] {
            teaDb.restockTea(id: tea.id, amount: newValue)
        }
        editingTeas.remove(tea.id)
    }
}
