//
//  AddTeaView.swift
//  assignment3
//
<<<<<<< Updated upstream
//  Created by Darren Marvin on 4/5/2025.
//

=======
//  Created by Delbert Charlie on 1/5/2025.
//

import SwiftUI

struct AddTeaView: View {
    @EnvironmentObject private var teaDb: TeaDb
    @Environment(\.presentationMode) private var presentation

    @State private var name      = ""
    @State private var tempMin   = ""
    @State private var tempMax   = ""
    @State private var amount    = ""
    @State private var steepTime = ""

    var body: some View {
        NavigationView {
            Form(content: {
                           Section("Tea Details") {
                               TextField("Name", text: $name)
                               TextField("Min Temp (°C)", text: $tempMin)
                                   .keyboardType(.decimalPad)
                               TextField("Max Temp (°C)", text: $tempMax)
                                   .keyboardType(.decimalPad)
                               TextField("Amount (g)", text: $amount)
                                   .keyboardType(.decimalPad)
                               TextField("Steep Time (sec)", text: $steepTime)
                                   .keyboardType(.numberPad)
                           }
           
                Section {
                    Button("Save Tea", action: {
                        guard
                          let minT = Double(tempMin),
                          let maxT = Double(tempMax),
                          let amt  = Double(amount),
                          let time = TimeInterval(steepTime)
                        else { return }
                        
                        teaDb.addTea(
                            name: name,
                            tempMin: minT,
                            tempMax: maxT,
                            amount: amt,
                            steepTime: time
                        )
                        presentation.wrappedValue.dismiss()
                    })
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
}
>>>>>>> Stashed changes
