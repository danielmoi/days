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
        let cell = UITableViewCell()
        let day = days[indexPath.row]

        cell.textLabel?.text = day.name
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
