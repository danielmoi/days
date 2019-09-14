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
        super.viewDidLoad()
        
        // UI elements
        notificationStateLabel.textColor = C.Colors.Alert
        explanationLabel.numberOfLines = 0
        explanationLabel.lineBreakMode = .byWordWrapping
        
        // Check current notification settings
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            
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
        center.delegate = self
        
        // Listen to NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(setNotificationsOn(notification:)), name: .notificationsOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setNotificationsOff(notification:)), name: .notificationsOff, object: nil)
    }
    
    @objc func setNotificationsOff(notification: NSNotification) {
        DispatchQueue.main.async {
            self.notificationsOffAction()
        }
    }
    @objc func setNotificationsOn(notification: NSNotification) {
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
        // Redirect
        UIApplication.shared.open(NSURL(string: UIApplication.openSettingsURLString)! as URL, options: [:]) { (bool) in
        }
        
    }
    
}
