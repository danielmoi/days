//
//  DayHelper.swift
//  Days
//
//  Created by Daniel Moi on 5/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func isDefaultDay(day: Day) -> Bool {
    let primaryUser = getPrimaryUser()
    let id = primaryUser?.badgeDayId
    if (day.id == id) {
        return true
    }
    return false
}

// Not using this
func getBadgeDay(dayId: UUID) -> Day? {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Day.fetchRequest() as NSFetchRequest<Day>
    
    fetchRequest.predicate = NSPredicate(format: "id == %@", dayId as NSUUID)
    
    var days: [Day] = []
    do {
        days = try context.fetch(fetchRequest)
        print("days:\(days)")
        if days.count == 0 {
            return nil
        }
        
    } catch {}
    return days[0]
}
