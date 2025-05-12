//
//  RandomiserView.swift
//  assignment3
//
//  Created by Tai Woodley on 27/4/2025.
//

import SwiftUI

struct RandomiserView: View {
    @EnvironmentObject var teaDb: TeaDb

    @State private var selectedType: TeaCategory = .green
    @State private var selectedTea: TeaModel? = nil
    
    // Filter teas by selected type
    var filteredTeas: [TeaModel] {
        teaDb.teas.filter { $0.category == selectedType }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Tea type picker
                Picker("Select Tea Type", selection: $selectedType) {
                    ForEach(TeaCategory.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: selectedType) {
                    // Clear selected tea when tea type changes
                    selectedTea = nil
                }
                
                // Pick a random tea from filtered list
                Button("Pick a Random Tea") {
                    if let random = filteredTeas.randomElement() {
                        selectedTea = random
                    }
                }
                .padding()
                .disabled(filteredTeas.isEmpty)
                
                // Show hint if no teas available in current type
                if filteredTeas.isEmpty {
                    Text("No teas of this type available.")
                        .foregroundColor(.gray)
                }

                if let tea = selectedTea {
                    VStack(spacing: 8) {
                        Text("Selected Tea: \(tea.name)")
                            .font(.title2)
                        Text("Water: \(tea.waterAmount) mL")
                        Text("Temp: \(tea.waterTemp) ºC")
                        Text("Time: \(tea.time) sec")

                        // Add explicit navigation button to TimerView
                        NavigationLink(destination: TimerView(tea: tea)) {
                            Label("Brew this tea 🍵", systemImage: "flame.fill")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .cornerRadius(8)
                        }
                        .padding(.top, 10)
                    }
                }

                Spacer()
            }
            .navigationTitle("Random Tea")
            .navigationDestination(for: TeaModel.self) { tea in
                // Destination view when using NavigationLink(value:)
                TimerView(tea: tea)
            }
        }
    }
}

#Preview {
    RandomiserView()
}
