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
    return difference
}

func getDiffDirection(difference: Int) -> String {
    if difference > 0 {
        return "until"
    }
    return "since"
}



func getDiffData(date: Date) -> (diffInt: Int, diffDirection: String) {
    let difference = getDiffInt(date: date)
    let diffInt = abs(difference)
    
    var diffDirection = ""
    if diffInt == 1 {
        diffDirection = "day \(getDiffDirection(difference: difference))"
    } else {
        diffDirection = "days \(getDiffDirection(difference: difference))"
    }
    
    return (diffInt, diffDirection)
}

