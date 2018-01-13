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
    @IBOutlet weak var notificationStateLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var redirectButton: UIButton!
    
    override func viewDidLoad() {
        print("WE IN DID LOAD")
        super.viewDidLoad()
        
        notificationStateLabel.textColor = UIColor(named: "DefaultDay")
        explanationLabel.numberOfLines = 0
        explanationLabel.lineBreakMode = .byWordWrapping
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            print("OK................. inside this little function")
            print("settings: \(settings)")
            
            
            if settings.badgeSetting == .enabled {
                DispatchQueue.main.async {
                    self.notificationsOnAction()
                }
            } else {
                DispatchQueue.main.async {
                    self.notificationsOffAction()
                }
                
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(setNotificationsOn(notification:)), name: .notificationsOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setNotificationsOff(notification:)), name: .notificationsOff, object: nil)
        
        
        center.delegate = self
        
    }
    
    @objc func setNotificationsOff(notification: NSNotification) {
        print("inside OFF")
        DispatchQueue.main.async {
            self.notificationsOffAction()
        }
    }
    @objc func setNotificationsOn(notification: NSNotification) {
        print("inside ON")
        DispatchQueue.main.async {
            self.notificationsOnAction()
        }
        
    }
    
    func notificationsOffAction() {
         self.notificationStateLabel.text = "OFF"
        self.explanationLabel.text = "This means that the badge count is not enabled. Turn your notification setting on to enable this feature"
        self.redirectButton.isHidden = false
    }
    func notificationsOnAction() {
        self.notificationStateLabel.text = "ON"
        self.explanationLabel.text = "This means that the badge count is enabled, and will sync with the count of your default day"
        self.redirectButton.isHidden = true
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
        }
        
    }
    
}
