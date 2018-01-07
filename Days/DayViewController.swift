//
//  DayViewController.swift
//  Days
//
//  Created by Daniel Moi on 30/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit

import CoreData


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
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        
        let user = getPrimaryUser()
        
        if (day == nil) {
            print("NIL")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            day = Day(context: context)
            day!.date = Date()
            day!.id = UUID()
        }
        
        nameTextField.text = day!.name
        
        let date = day!.date!
        
        // calculate days between today and date
        let diffData = getDiffData(date: date)
        print("DIFF DATA\(diffData)")
        diffInt = diffData.diffInt
        diffDirection = diffData.diffDirection
        daysLabel.text = String(diffInt)
        diffDirectionLabel.text = diffData.diffDirection
        defaultSwitch.isOn = user?.badgeDayId == day!.id
        
        datePicker.date = date
    }
    
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let date = datePicker.date
        // calculate days between today and date
        let diffData = getDiffData(date: date)
        diffInt = diffData.diffInt
        diffDirection = diffData.diffDirection
        daysLabel.text = String(diffInt)
        diffDirectionLabel.text = diffData.diffDirection
    }
    
    
    
    @IBAction func saveTapped(_ sender: Any) {
        let date = datePicker.date
        
        day!.date = date
        day!.name = nameTextField.text
        
        
        if defaultSwitch.isOn {
            let user = getPrimaryUser()
            user?.badgeDayId = day?.id
            print("PRIMARY USER: \(user)")
            
        } else {
            print("NAH NOTHING INTERESTING...")
            
        }
        day!.isDefault = defaultSwitch.isOn
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // set badge
        UIApplication.shared.applicationIconBadgeNumber = diffInt
        
        // trigger notification
        print("diffDirection: \(diffDirection)")
        triggerBadgeNotification(direction: diffDirection)
        
        // Go back to list view
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(day!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    
}

