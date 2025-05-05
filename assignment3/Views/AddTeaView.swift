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
    @State private var tempText     = ""
    @State private var timeText     = ""
    @State private var urlString    = ""
    
    var body: some View {
        NavigationView {
            Form(content: {
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
                    Button("Save Tea") {
                        saveTea()
                    }
                    .disabled(name.isEmpty)
                }
            })
            .navigationTitle("Add New Tea")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func saveTea() {
        guard
            let amt   = Int(amountText),
            let temp  = Int(tempText),
            let secs  = Int(timeText)
        else {
            return
        }
    }
    
        struct AddTeaView_Previews: PreviewProvider {
            static var previews: some View {
                AddTeaView()
                    .environmentObject(TeaDb())
            }
        }
    }

