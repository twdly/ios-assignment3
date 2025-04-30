//
//  NotificationDelegate.swift
//  assignment3
//
//  Created by Tai Woodley on 28/4/2025.
//

import Foundation
import UIKit

// I found that the official documentation wasn't great for handling foreground notifications but this stackoverflow answer helped immensely: https://stackoverflow.com/a/65782594
class NotificationDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension NotificationDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification received with identifier \(notification.request.identifier)")
        completionHandler([.banner, .sound])
    }
}
