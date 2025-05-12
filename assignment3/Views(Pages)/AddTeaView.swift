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
    @State private var name : String        = ""
    @State private var selectedType: TeaCategory = .black
    @State private var amountText   = ""
    @State private var teaType: TeaType = .Loose
    @State private var tempText     = ""
    @State private var timeText     = ""
    @State private var urlString    = ""
    @State private var stock: String = ""
    @State private var useAmt: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Tea Details") {
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
                        // Validate numeric inputs before saving
                        guard
                            let amt = Int(amountText),
                            let tmp = Int(tempText),
                            let secs = Int(timeText),
                            let stockAmt = Int(stock),
                            let useAmt = Int(useAmt)
                        else { return }
                        
                        // Notify SwiftUI that data will change
                        teaDb.objectWillChange.send()
                        
                        // Generate a unique ID for the new tea (max existing ID + 1)
                        let nextID = (teaDb.teas.map(\.id).max() ?? -1) + 1
                        
                        // Create new TeaModel object to store
                        let newTea = TeaModel(
                            id: nextID,
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
                        // Dismiss the add tea view
                        presentation.wrappedValue.dismiss()
                        // Add new tea to the tea database
                        teaDb.addTea(newTea)
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("New Tea")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // If user taps "Cancel", close the add view
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
