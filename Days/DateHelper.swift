//
//  DateHelper.swift
//  Days
//
//  Created by Daniel Moi on 2/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//

import Foundation

func getDiffInt(date: Date) -> Int {
    let calendar = NSCalendar.current
    let today = Date()
    
    let startOfToday = calendar.startOfDay(for: today)
    let startOfDate = calendar.startOfDay(for: date)
    
    let components = calendar.dateComponents([.day], from: startOfToday, to: startOfDate)
    let difference = components.day!
    print("difference:\(difference)")
    return abs(difference)
}

func getDiffDisplay(difference: Int) -> String {
    if difference > 0 {
        return "until"
    }
    return "since"
}

func getDiffData(date: Date) -> (diffInt: Int, diffDisplay: String) {
    let diffInt = getDiffInt(date: date)
    let diffDisplay = getDiffDisplay(difference: diffInt)
    return (diffInt, diffDisplay)
}

// have 2 separate functions

/* return a dictionary
 
 ["diffInt": 3, "diffDisplay": "since"]
 
 
 */
