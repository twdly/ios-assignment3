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
    @State private var selectedType: TeaCategory = .black
    @State private var amountText: String = ""
    @State private var tempText: String = ""
    @State private var timeText: String = ""
    @State private var teaType: TeaType = .Loose
    @State private var urlString: String = ""
    @State private var stock: String = ""
    @State private var useAmt: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("🍵 Tea Details")) {
                    // Tea Name
                    HStack {
                        Text("🫖")
                        TextField("Name", text: $name)
                    }
                    
                    // Tea Category
                    Picker("Tea Category", selection: $selectedType) {
                        ForEach(TeaCategory.allCases, id: \.self) { t in
                            Text(t.rawValue.capitalized).tag(t)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // Tea Type (Bag or Loose)
                    Picker("Tea Type", selection: $teaType) {
                        ForEach(TeaType.allCases, id: \.self) { t in
                            Text(t.rawValue.capitalized).tag(t)
                        }
                    }
                    .pickerStyle(.segmented)

                    HStack {
                        Text("💧")
                        TextField("Water Amount (ml)", text: $amountText)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("🌡️")
                        TextField("Water Temp (°C)", text: $tempText)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("⏱️")
                        TextField("Steep Time (sec)", text: $timeText)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("📦")
                        TextField("Amount Stocked (grams or bags)", text: $stock)
                            .keyboardType(.numberPad)
                    }
                
                    HStack {
                        Text("📏")
                        TextField("Amount used per brew", text: $useAmt)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("🔗")
                        TextField("URL (optional)", text: $urlString)
                            .keyboardType(.URL)
                    }
                }

                Section {
                    Button("Save Tea") {
                        // Validate that all required inputs are valid integers
                        guard
                            let amt = Int(amountText),
                            let tmp = Int(tempText),
                            let secs = Int(timeText),
                            let stockAmt = Int(stock),
                            let useAmt = Int(useAmt)
                        else { return }
                        
                        // Notify SwiftUI that TeaDb is about to change
                        teaDb.objectWillChange.send()

                        // Create a new TeaModel with the same ID to update the existing tea
                        let newTea = TeaModel(
                            id: originalTea.id,
                            name: name,
                            category: selectedType,
                            teaType: teaType,
                            waterAmount: amt,
                            waterTemp: tmp,
                            time: secs,
                            url: urlString.isEmpty ? nil : urlString,
                            teaUsedPerBrew: useAmt,
                            amountStocked: stockAmt
                            
                        )
                        // Dismiss the edit view
                        presentation.wrappedValue.dismiss()
                        // Call updateTea to apply changes to the tea list
                        teaDb.updateTea(newTea)
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("Edit Tea")
            .onAppear {
                // Pre-fill form fields with original tea data when the view appears
                name = originalTea.name
                selectedType = originalTea.category
                amountText = String(originalTea.waterAmount)
                tempText = String(originalTea.waterTemp)
                timeText = String(originalTea.time)
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
        teaType: .Loose,
        waterAmount: 250,
        waterTemp: 100,
        time: 180,
        url: "https://example.com",
        teaUsedPerBrew: 2,
        amountStocked: 100
    ))
    .environmentObject(TeaDb())
}
