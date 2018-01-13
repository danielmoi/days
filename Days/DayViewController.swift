//
//  DayViewController.swift
//  Days
//
//  Created by Daniel Moi on 30/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit

import CoreData
import UserNotifications


class DayViewController: UIViewController, UITextFieldDelegate {
    
    // connections
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var diffDirectionLabel: UILabel!
    @IBOutlet weak var defaultSwitch: UISwitch!
    
    // properties
    var diffInt: Int = 0
    var diffDirection: String = ""
    var day: Day? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        nameTextField.autocapitalizationType = .sentences
        
        let user = getPrimaryUser()
        print("user:\(user)")
        
        if (day == nil) {
            // ie. we are creating a new day
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            day = Day(context: context)
            print("day:\(day)")
            day!.date = Date()
            day!.id = UUID()
        }
        
        processDateDifference(date: day!.date!)
        
        // update relevant ui elements
        nameTextField.text = day!.name
        defaultSwitch.isOn = user?.badgeDayId == day!.id
        datePicker.date = day!.date!
    }
    
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        processDateDifference(date: datePicker.date)
    }
    
    func processDateDifference(date: Date) {
        // calculate day difference between selected date and today
        let diffData = getDiffData(date: date)
        diffInt = diffData.diffInt
        diffDirection = diffData.diffDirection
        
        // update relevant ui elements
        daysLabel.text = String(diffInt)
        diffDirectionLabel.text = diffData.diffDirection
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        // set Day
        day!.date = datePicker.date
        day!.name = nameTextField.text
        
        if defaultSwitch.isOn {
            // save this day on the primary user
            let user = getPrimaryUser()
            user?.badgeDayId = day?.id
            print("PRIMARY USER: \(user)")
            
            // set badge because this is the default day
            UIApplication.shared.applicationIconBadgeNumber = diffInt
            
            // trigger notification based on this default day
            triggerBadgeNotification(direction: diffDirection)
            
        } else {
            print("This day is not default, not saving onto primary user")
        }
        
        // save Day
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        
        // Go back to list view
        navigationController!.popViewController(animated: true)
    }
    
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(day!)
        
        // Remove the notification if this day is the default day
        if (isDefaultDay(day: day!)) {
            print("Is default day, deleting pending notification requests......")
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            
            // Reset Badge
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    // Make keyboard disappear when "Return" is tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    
}

