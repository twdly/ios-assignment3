//
//  AddTeaView.swift
//  assignment3
//
//  Created by Delbert Charlie on 1/5/2025.
//
import SwiftUI
struct AddTeaView: View {
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
                
                
                    Button("Save Tea") {
                        presentation.wrappedValue.dismiss()
                    }
                    
            })
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
