//
//  SettingsViewController.swift
//  Days
//
//  Created by Daniel Moi on 7/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsViewController: UIViewController, UNUserNotificationCenterDelegate {

    // connections
    @IBOutlet weak var badgeSwitch: UISwitch!
    @IBOutlet weak var notificationStateLabel: UILabel!
    
    override func viewDidLoad() {
        print("WE IN DID LOAD")
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            print("settings: \(settings)")
            
            let badgeEnabled = (settings.badgeSetting == .enabled)
            self.badgeSwitch.isOn = badgeEnabled
            
            if settings.badgeSetting == .enabled {
                print("ENABLED")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(setNotificationsOn(notification:)), name: .notificationsOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setNotificationsOff(notification:)), name: .notificationsOff, object: nil)
        
        
        center.delegate = self
        
    }
    
    @objc func setNotificationsOff(notification: NSNotification) {
        print("inside OFF")
        DispatchQueue.main.async {
            self.notificationStateLabel.text = "OFF"
        }
    }
    @objc func setNotificationsOn(notification: NSNotification) {
        print("inside ON")
        DispatchQueue.main.async {
            self.notificationStateLabel.text = "ON"
        }
        
    }
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            print("settings: \(settings)")
        }
        center.getPendingNotificationRequests { (requests) in
            print("Pending Notifications ***********:\(requests)")
        }
        
        center.getDeliveredNotifications { (requests) in
            print("Delivered Notifications: \(requests)")
        }
        UIApplication.shared.open(NSURL(string: UIApplicationOpenSettingsURLString)! as URL, options: [:]) { (bool) in
            print("bool:\(bool)")
        }

    }
    
    @IBAction func switchTapped(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        if badgeSwitch.isOn {
            print("ON")
            
            center.requestAuthorization(options: [.sound, .alert, .badge], completionHandler: { (granted, error) in
                print("Granted:\(granted)")
                print("Error: \(error)")
            })
        } else {
            print("OFF")
            center.removeAllPendingNotificationRequests()
        }
        
    }
}
