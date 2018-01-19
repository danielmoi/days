//
//  DaysViewController.swift
//  Days
//
//  Created by Daniel Moi on 1/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//

import UIKit
import UserNotifications

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // connections
    @IBOutlet weak var tableView: UITableView!
    
    // properties
    var days: [Day] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDays()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCellTableViewCell
        
        let day = days[indexPath.row]
        
        let data = getDiffData(date: day.date!)
        
        // Day Name
        cell.dayNameLabel.text = day.name
        cell.dayDirectionLabel.text = "\(String(data.diffInt)) \(data.diffDirection)"
        
        // Day Direction
        var fnt = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.thin)
        if let dsc = fnt.fontDescriptor.withSymbolicTraits(.traitItalic) {
            fnt = UIFont(descriptor: dsc, size: 0)
        }
        cell.dayDirectionLabel.font = fnt
        
        // Default Day
        if (isDefaultDay(day: day)) {
            cell.dayNameLabel?.textColor = C.Colors.Alert
            cell.dayDirectionLabel?.textColor = C.Colors.Alert
        } else {
            cell.dayNameLabel?.textColor = C.Colors.TextNormal
            cell.dayDirectionLabel?.textColor = C.Colors.TextNormal
        }

        return cell
    }
    
    func getDays() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            days = try context.fetch(Day.fetchRequest()) as! [Day]
        } catch {
            print("ERROR")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        print("day:\(day)")
        performSegue(withIdentifier: "viewDaySegue", sender: day)
    }
    

    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "viewDaySegue", sender: nil )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewDaySegue") {
            let nextVC = segue.destination as! DayViewController
            nextVC.day = sender as? Day
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let day = days[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(day)
            
            // Remove the notification if this day is the default day
            if (isDefaultDay(day: day)) {
                print("Is default day, deleting pending notification requests......")
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                days = try context.fetch(Day.fetchRequest())
                tableView.reloadData()
            } catch {}
        }
    }

}
