//
//  assignment3App.swift
//  assignment3
//
//  Created by Tai Woodley on 26/4/2025.
//

import SwiftUI

@main
struct assignment3App: App {
    @UIApplicationDelegateAdaptor(NotificationDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
