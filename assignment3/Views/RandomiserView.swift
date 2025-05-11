//
//  RandomiserView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct RandomiserView: View {
    @EnvironmentObject var teaDb: TeaDb

    @State private var selectedType: TeaType = .green
    @State private var selectedTea: TeaModel? = nil

    var filteredTeas: [TeaModel] {
        teaDb.teas.filter { $0.type == selectedType }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Picker("Select Tea Type", selection: $selectedType) {
                    ForEach(TeaType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: selectedType) {
                    selectedTea = nil
                }

                Button("Pick a Random Tea") {
                    if let random = filteredTeas.randomElement() {
                        selectedTea = random
                    }
                }
                .padding()
                .disabled(filteredTeas.isEmpty)

                if filteredTeas.isEmpty {
                    Text("No teas of this type available.")
                        .foregroundColor(.gray)
                }

                if let tea = selectedTea {
                    NavigationLink(value: tea) {
                        VStack(spacing: 8) {
                            Text("Selected Tea: \(tea.name)")
                                .font(.title2)
                                .padding(.top)
                            Text("Water: \(tea.waterAmount) mL")
                            Text("Temp: \(tea.waterTemp) ºC")
                            Text("Time: \(tea.time) sec")
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Random Tea")
            .navigationDestination(for: TeaModel.self) { tea in
                TimerView(tea: tea)
            }
        }
    }
}

#Preview {
    RandomiserView()
}
