//
//  NotificationHelper.swift
//  Days
//
//  Created by Daniel Moi on 4/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//


import UIKit
import Foundation

// Notification have been extracted out of UIKit
import UserNotifications


// Trigger when a day is saved as the default
func triggerBadgeNotification(direction: String) {
    var dateComponents = DateComponents()
    dateComponents.hour = 0
    dateComponents.minute = 0
    
    let content = UNMutableNotificationContent()
    
    if direction == "days since" {
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
    } else if direction == "days until" {
        content.badge = UIApplication.shared.applicationIconBadgeNumber - 1 as NSNumber
    }
    
    content.categoryIdentifier = "badgeIdentifier"
    
    // ensure badge is updated even when app is running
//    content.setValue("YES", forKeyPath: "shouldAlwaysAlertWhileAppIsForeground")
    
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    // no need to clear all pending notifications because we are overwriting the "Daily" notification
    let request = UNNotificationRequest.init(identifier: "Daily", content: content, trigger: trigger)
    
    // Schedule the notification.
    let center = UNUserNotificationCenter.current()
    
    
    center.add(request) { (error) in
    }
}

// Not using this function - delete if not used when app is finished
func getBadgeNumber() -> Int {
    let user = getPrimaryUser()
    let dayId = user?.badgeDayId
    if !(dayId != nil) {
        return 0
    }
    let badgeDay = getBadgeDay(dayId: dayId!)
    let badgeDate = badgeDay?.date
    let diffData = getDiffData(date: badgeDate!)
    let diffInt = diffData.diffInt
    return diffInt
    
}
