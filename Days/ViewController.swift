//
//  ViewController.swift
//  Days
//
//  Created by Daniel Moi on 30/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    }
    
}

