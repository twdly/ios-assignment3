//
//  EditTeaView.swift
//  assignment3
//
//  Created by Delbert Charlie on 7/5/2025.
//

import SwiftUI

struct EditTeaView: View {
    @EnvironmentObject private var teaDb: TeaDb
    @Environment(\.presentationMode) private var presentation
    
    let originalTea: TeaModel
    
    @State private var name: String = ""
    @State private var selectedType: TeaType = .black
    @State private var amountText: String = ""
    @State private var tempText: String = ""
    @State private var timeText: String = ""
    @State private var descString: String = ""
    @State private var teaType: String = ""
    @State private var urlString: String = ""
    @State private var stock: String = ""
    @State private var useAmt: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Tea Details") {
                    TextField("Name", text: $name)

                    Picker("Tea Category", selection: $selectedType) {
                        ForEach(TeaType.allCases, id: \.self) { t in
                            Text(t.rawValue.capitalized).tag(t)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Tea Type", selection: $teaType) {
                        ForEach(["Teabag", "Loose"], id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }

                    TextField("Water Amount (ml)", text: $amountText)
                        .keyboardType(.numberPad)
                    TextField("Water Temp (°C)", text: $tempText)
                        .keyboardType(.numberPad)
                    TextField("Steep Time (sec)", text: $timeText)
                        .keyboardType(.numberPad)
                    TextField("Description", text: $descString)
                    TextField("Amount Stocked (grams or bags)", text: $stock)
                        .keyboardType(.numberPad)
                    TextField("Amount used per brew", text: $useAmt)
                        .keyboardType(.numberPad)
                    TextField("URL (optional)", text: $urlString)
                        .keyboardType(.URL)
                }

                Section {
                    Button("Save Changes") {
                        guard
                            let amt = Int(amountText),
                            let tmp = Int(tempText),
                            let secs = Int(timeText),
                            let stockAmt = Int(stock),
                            let usedAmt = Int(useAmt)
                        else { return }

                        teaDb.objectWillChange.send()

                        if let idx = teaDb.teas.firstIndex(where: { $0.id == originalTea.id }) {
                            teaDb.teas[idx] = TeaModel(
                                id: originalTea.id,
                                name: name,
                                category: selectedType,
                                teaType: teaType,
                                waterAmount: amt,
                                waterTemp: tmp,
                                time: secs,
                                url: urlString.isEmpty ? nil : urlString,
                                description: descString,
                                teaUsedPerBrew: usedAmt,
                                amountStocked: stockAmt
                            )
                        }

                        presentation.wrappedValue.dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("Edit Tea")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                name = originalTea.name
                selectedType = originalTea.category
                amountText = String(originalTea.waterAmount)
                tempText = String(originalTea.waterTemp)
                timeText = String(originalTea.time)
                descString = originalTea.description
                teaType = originalTea.teaType
                urlString = originalTea.url ?? ""
                stock = String(originalTea.amountStocked)
                useAmt = String(originalTea.teaUsedPerBrew)
            }
        }
    }
}

#Preview {
    EditTeaView(originalTea: TeaModel(
        id: 0,
        name: "Sample Tea",
        category: .black,
        teaType: "Loose",
        waterAmount: 250,
        waterTemp: 100,
        time: 180,
        url: "https://example.com",
        description: "Sample description",
        teaUsedPerBrew: 2,
        amountStocked: 100
    ))
    .environmentObject(TeaDb())
}
