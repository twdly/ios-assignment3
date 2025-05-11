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
    @State private var urlString: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Tea Details") {
                    TextField("Name", text: $name)

                    Picker("Type", selection: $selectedType) {
                        ForEach(TeaType.allCases, id: \.self) { t in
                            Text(t.rawValue.capitalized).tag(t)
                        }
                    }
                    .pickerStyle(.segmented)

                    TextField("Water Amount (ml)", text: $amountText)
                        .keyboardType(.numberPad)
                    TextField("Water Temp (°C)", text: $tempText)
                        .keyboardType(.numberPad)
                    TextField("Steep Time (sec)", text: $timeText)
                        .keyboardType(.numberPad)
                    TextField("URL (optional)", text: $urlString)
                        .keyboardType(.URL)
                }

                Section {
                    Button("Save Changes") {
                        guard
                            let amt = Int(amountText),
                            let tmp = Int(tempText),
                            let secs = Int(timeText)
                        else { return }

                        teaDb.objectWillChange.send()

                        if let model = teaDb.teas.first(where: { $0.id == originalTea.id }) {
                            model.name        = name
                            model.type        = selectedType
                            model.waterAmount = amt
                            model.waterTemp   = tmp
                            model.time        = secs
                            model.url         = urlString.isEmpty ? nil : urlString
                        }

                        presentation.wrappedValue.dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .navigationTitle("Edit Tea")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                }
            }
            .onAppear {
                name = originalTea.name
                selectedType = originalTea.type
                amountText = String(originalTea.waterAmount)
                tempText = String(originalTea.waterTemp)
                timeText = String(originalTea.time)
                urlString = originalTea.url ?? ""
            }
        }
    }
}

#Preview {
    EditTeaView(originalTea: TeaModel(
        id: 0,
        name: "",
        type: .black,
        waterAmount: 0,
        waterTemp: 0,
        time: 0,
        url: nil
    ))
    .environmentObject(TeaDb())
}
