//
//  NotificationHelper.swift
//  Days
//
//  Created by Daniel Moi on 4/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//


import UIKit
import Foundation
//    Notification become independent from UIKit
import UserNotifications

/*
 https://stackoverflow.com/questions/37938771/uilocalnotification-is-deprecated-in-ios10
 https://www.hackingwithswift.com/example-code/system/how-to-set-local-alerts-using-unnotificationcenter
 */

// Move to save?

func triggerNotification(){
    print("IN TRIGGER NOTIFICATION")
    var dateComponents = DateComponents()
    dateComponents.hour = 0
    dateComponents.minute = 0
    
    let content = UNMutableNotificationContent()
    content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber;
    content.categoryIdentifier = "badgeIdentifier"
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest.init(identifier: "Daily", content: content, trigger: trigger)
    
    // Schedule the notification.
    let center = UNUserNotificationCenter.current()
    center.add(request) { (error) in
        print("Error in scheduling: \(error)")
    }
}
