//
//  ToDoApp.swift
//  ToDo
//
//  Created by Esteban SEMELLIER on 05/01/2023.
//

import SwiftUI

@main
struct ToDoApp: App {
    private let notificationManager = NotificationManager()

    init() {

        setupNotifications()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager(), notificationManager: notificationManager)
                
        }
    }
    private func setupNotifications() {
        notificationManager.notificationCenter.delegate = notificationManager
        notificationManager.handleNotification = handleNotification

        requestNotificationsPermission()
    }

    private func handleNotification(notification: UNNotification) {
        print("<<<DEV>>> Notification received: \(notification.request.content.userInfo)")
    }

    private func requestNotificationsPermission() {
        notificationManager.requestPermission(completionHandler: { isGranted, error in
            if isGranted {
                // handle granted success
            }

            if let _ = error {
                // handle error

                return
            }
        })
    }
}
