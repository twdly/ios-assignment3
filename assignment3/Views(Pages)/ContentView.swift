//
//  ContentView.swift
//  assignment3
//
//  Created by Tai Woodley on 26/4/2025.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var teaDb: TeaDb = TeaDb()
    
    @State private var selectedTab: Tabs = .teas
    @State private var showAlert: Bool = false
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Teas", systemImage: "cup.and.saucer.fill", value: .teas) {
                TeaListView()
            }
            Tab("Timers", systemImage: "clock", value: .timers) {
                TimerListView()
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
        }.alert("Enable notifications", isPresented: $showAlert, actions: {}, message: {
            Text("This app is designed to work best with notifications. Please enable notifications in the settings.")
        })
        .onAppear(perform: requestNotificationPermissions)
        .environmentObject(teaDb)
    }
    
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
            if !success {
                showAlert = true
            }
        }
    }
}

#Preview {
    ContentView()
}
