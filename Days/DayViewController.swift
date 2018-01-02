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
    @IBOutlet weak var diffDisplayLabel: UILabel!
    
    // properties
    var diffInt: Int = 0
    var diffDisplay: String = ""
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
        
        
        var date = Date()
        if day!.date != nil {
            date = day!.date!
        }
        
        // calculate days between today and date
        let diffData = getDiffData(date: date)
        diffInt = diffData.diffInt
        daysLabel.text = String(diffInt)
        diffDisplayLabel.text = diffData.diffDisplay
        
        // authorization for notifications
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }

        UIApplication.shared.applicationIconBadgeNumber = 1
    }
    
    

    @IBAction func datePickerChanged(_ sender: Any) {
        let date = datePicker.date
        // calculate days between today and date
        let diffData = getDiffData(date: date)
        diffInt = diffData.diffInt
        daysLabel.text = String(diffInt)
        diffDisplayLabel.text = diffData.diffDisplay
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let date = datePicker.date
        
        day!.date = date
        day!.name = nameTextField.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
   
        // set badge
        UIApplication.shared.applicationIconBadgeNumber = diffInt
        
        // Go back to list view
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(day!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}

