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
    var diffInt: Int = 0
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
        
        // calculate days between today and date
        let diffData = getDiffData(date: day!.date!)
        diffInt = diffData.diffInt
        daysLabel.text = String(diffInt)
        
        // authorization for notifications
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }

        UIApplication.shared.applicationIconBadgeNumber = 1
    }


    @IBAction func saveTapped(_ sender: Any) {
        let date = datePicker.date
        
        day!.date = date
        day!.name = nameTextField.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print("day:\(day)")

   
        // set badge
        UIApplication.shared.applicationIconBadgeNumber = diffInt
    }
    
}

