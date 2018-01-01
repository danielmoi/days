//
//  ViewController.swift
//  Days
//
//  Created by Daniel Moi on 30/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }

        UIApplication.shared.applicationIconBadgeNumber = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let day = Day(context: context)
        
        let date = datePicker.date
        
        day.date = date
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print("day:\(day)")

        // calculate days between today and date
        let calendar = NSCalendar.current
        let today = Date()
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: today, to: date2)
        let difference = components.day!
        
        print("difference:\(difference)")
        
   
        // set badge
        UIApplication.shared.applicationIconBadgeNumber = difference
    }
    
}

