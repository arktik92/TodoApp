//
//  NotificationHelper.swift
//  ToDo
//
//  Created by Esteban SEMELLIER on 06/01/2023.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationHelper {
    static func getTriggerDate(triggerDate: Date) -> DateComponents? {
//        let triggerDate =  triggerDate
        return Calendar.current.dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second], from: triggerDate)
    }
}
