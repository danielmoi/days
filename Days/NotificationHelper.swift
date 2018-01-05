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

// 1. Move to save on selecting DEFAULT
// 2. Make the badge increment or decrement
// 3. Handle "out of range" - it's past = set to "0"

func triggerNotification() {
    print("IN TRIGGER NOTIFICATION")
    var dateComponents = DateComponents()
    dateComponents.hour = 0
    dateComponents.minute = 0
    
    let content = UNMutableNotificationContent()
    content.badge = getBadgeNumber() as NSNumber;
    content.categoryIdentifier = "badgeIdentifier"
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest.init(identifier: "Daily", content: content, trigger: trigger)
    
    // Schedule the notification.
    let center = UNUserNotificationCenter.current()
    center.add(request) { (error) in
        print("Error in scheduling: \(error)")
    }
}

func getBadgeNumber() -> Int {
    print("****************")
    print("GETTING BADGE NUMBER!!!!!!!!!!")
    let user = getPrimaryUser()
    let dayId = user?.badgeDayId
    if !(dayId != nil) {
        return 0
    }
    let badgeDay = getBadgeDay(dayId: dayId!)
    let badgeDate = badgeDay?.date
    let diffData = getDiffData(date: badgeDate!)
    let diffInt = diffData.diffInt
    print("****************")
    print("diffData:\(diffData)")
    print("diffInt:\(diffInt)")
    return diffInt
    
}
