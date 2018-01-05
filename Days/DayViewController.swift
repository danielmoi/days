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
    @IBOutlet weak var diffDisplayLabel: UILabel!
    @IBOutlet weak var defaultSwitch: UISwitch!
    
    // properties
    var diffInt: Int = 0
    var diffDisplay: String = ""
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
        daysLabel.text = String(diffInt)
        diffDisplayLabel.text = diffData.diffDisplay
        defaultSwitch.isOn = user?.badgeDayId == day!.id
        
        datePicker.date = date
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
        
        
        if defaultSwitch.isOn {
            print("SETTING TO DEFAULT")
            let defaultDays = getDefaultDays()
            print("&&&defaultDays: \(defaultDays)")
            let user = getPrimaryUser()
            user?.badgeDayId = day?.id
            print("PRIMARY USER: \(user)")
//            unsetDefaultDays(days: defaultDays)
            
        } else {
            print("NAH NOTHING INTERESTING...")
            
        }
        day!.isDefault = defaultSwitch.isOn
        
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
    
    @IBAction func switchTapped(_ sender: Any) {
        let value = defaultSwitch.isOn
        print("++++++++: \(value)")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    
    func getDefaultDays() -> [Day] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = Day.fetchRequest() as NSFetchRequest<Day>
        
        fetchRequest.predicate = NSPredicate(format: "isDefault == %@", NSNumber(booleanLiteral: true))
        
        do {
            let days = try context.fetch(fetchRequest)
            
            return days
        } catch {}
        return []
    }
    
    func unsetDefaultDays(days: [Day]) {
        print("-- days: \(days)")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSBatchUpdateRequest(entityName: "Day")
        request.propertiesToUpdate = ["isDefault" : false]
        do {
            let result = try context.execute(request) as? NSBatchUpdateResult
            print("********* RESULT: \(result)")
            
        } catch {
            
            print("Failed to execute request: \(error)")
            
        }
    }
}

