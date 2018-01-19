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
    @IBOutlet weak var saveButton: UIButton!
    
    
    // properties
    var diffInt: Int = 0
    var diffDirection: String = ""
    var day: Day? = nil
    var date: Date = Date()
    var name: String = ""
    var id: UUID = UUID()
    var isDefault: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        nameTextField.autocapitalizationType = .sentences
        saveButton.layer.cornerRadius = 4
        
        saveButton.contentEdgeInsets = UIEdgeInsetsMake(10,20,10,20)
        saveButton.setTitleColor(C.Colors.BtnTextInactive, for: .disabled)
        saveButton.setTitleColor(C.Colors.BtnText, for: .normal)
        
        let user = getPrimaryUser()
        
        if (day != nil) {
            // ie. this is a new day
            date = day!.date!
            id = day!.id!
            name = day!.name!
        }
        
        processDateDifference(date: date)
        
        // update relevant ui elements
        nameTextField.text = name
        defaultSwitch.isOn = user?.badgeDayId == id
        datePicker.date = date
        
        if (nameTextField.text?.isEmpty)! {
            saveButton.backgroundColor = C.Colors.BtnBgInactive
            saveButton.isEnabled = false

        } else {
            saveButton.backgroundColor = C.Colors.BtnBgPrimary
            saveButton.isEnabled = true
        }
        
    }
    
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        processDateDifference(date: datePicker.date)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if (newString.isEmpty) {
            saveButton.backgroundColor = C.Colors.BtnBgInactive
            saveButton.isEnabled = false
        } else {
            saveButton.backgroundColor = C.Colors.BtnBgPrimary
            saveButton.isEnabled = true
        }
        return true
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

        if (day == nil) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            day = Day(context: context)
        }
        
        day!.date = datePicker.date
        day!.name = nameTextField.text
        day!.id = id
        
        if defaultSwitch.isOn {
            // save this day on the primary user
            let user = getPrimaryUser()
            user?.badgeDayId = day?.id
            
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

