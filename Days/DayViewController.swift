//
//  DayViewController.swift
//  Days
//
//  Created by Daniel Moi on 30/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit
import UserNotifications


class DayViewController: UIViewController {

    // connections
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    // properties
    var difference: Int = 0
    var day: Day? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (day == nil) {
            print("NIL")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            day = Day(context: context)
        }
        
        nameTextField.text = day!.name
        datePicker.date = day!.date!
        
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
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//        let day = Day(context: context)
        
        let date = datePicker.date
        
        day!.date = date
        day!.name = nameTextField.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print("day:\(day)")

        // calculate days between today and date
        let calendar = NSCalendar.current
        let today = Date()
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: today, to: date2)
        let difference = components.day!
        
        let displayDifference = abs(difference)
        daysLabel.text = String(displayDifference)
        
        print("difference:\(difference)")
        
   
        // set badge
        UIApplication.shared.applicationIconBadgeNumber = displayDifference
    }
    
}

