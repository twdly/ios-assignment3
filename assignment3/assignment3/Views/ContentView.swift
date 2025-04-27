//
//  ContentView.swift
//  assignment3
//
//  Created by Tai Woodley on 26/4/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tabs = .teas
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Teas", systemImage: "cup.and.saucer.fill", value: .teas) {
                TeaListView()
            }
            Tab("Randomiser", systemImage: "dice", value: .randomiser) {
                RandomiserView()
            }
            Tab("Stock", systemImage: "bag", value: .stock) {
                StockView()
            }
            Tab("Reviews", systemImage: "star", value: .reviews) {
                ReviewView()
            }
        }
    }
}

#Preview {
    ContentView()
}
