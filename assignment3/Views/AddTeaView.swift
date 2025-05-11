//
//  AddTeaView.swift
//  assignment3
//
//  Created by Delbert Charlie on 1/5/2025.
//
import SwiftUI
struct AddTeaView: View {
    @EnvironmentObject private var teaDb: TeaDb
    @Environment(\.presentationMode) private var presentation
    @State private var name         = ""
    @State private var selectedType: TeaType = .black
    @State private var amountText   = ""
    @State private var teaType: String = ""
    @State private var tempText     = ""
    @State private var timeText     = ""
    @State private var descString    = ""
    @State private var urlString    = ""
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
                        .keyboardType(.numberPad)
                    TextField("Amount Stocked (grams or bags)", text: $stock)
                        .keyboardType(.numberPad)
                
                    TextField("Amount used per brew", text: $useAmt)
                        .keyboardType(.numberPad)
                    TextField("URL (optional)", text: $urlString)
                        .keyboardType(.URL)
                }

                Section {
                    Button("Save Tea") {
                        guard
                            let amt = Int(amountText),
                            let tmp = Int(tempText),
                            let secs = Int(timeText),
                            let stockAmt = Int(stock),
                            let useAmt = Int(useAmt)
                        else { return }
                        
                        teaDb.objectWillChange.send()

                        let nextID = (teaDb.teas.map(\.id).max() ?? -1) + 1

                        let newTea = TeaModel(
                            id: nextID,
                            name: name,
                            category: selectedType,
                            teaType: teaType,
                            waterAmount: amt,
                            waterTemp: tmp,
                            time: secs,
                            url: urlString.isEmpty ? nil : urlString,
                            description: descString,
                            teaUsedPerBrew: useAmt,
                            amountStocked: stockAmt
                            
                        )
                        presentation.wrappedValue.dismiss()
                        
                        teaDb.addTea(newTea)
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("New Tea")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTeaView().environmentObject(TeaDb())
}
