//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"
var dateComponents = DateComponents()
dateComponents.year = 2015
dateComponents.month = 1
dateComponents.day = 1
dateComponents.hour = 0
dateComponents.minute = 0
//Create an NSDate from the date components

var calendar = Calendar(identifier: .gregorian)
var configuredDate: Date? = calendar.date(from: dateComponents)
//Schedule a local notification, set the repeatInterval to daily
var localNotification = UILocalNotification()
localNotification.fireDate = configuredDate
localNotification.alertBody = nil
localNotification.alertAction = nil
localNotification.timeZone = NSTimeZone.default
localNotification.repeatInterval = .day
//Add one to the icon badge number
localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
