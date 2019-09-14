//
//  UserHelper.swift
//  Days
//
//  Created by Daniel Moi on 5/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func createPrimaryUser() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let user = User(context: context)
    user.name = "primary"
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func getPrimaryUser() -> User? {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
    
    fetchRequest.predicate = NSPredicate(format: "name == %@", "primary")
    
    var users: [User] = []
    do {
        users = try context.fetch(fetchRequest)
        
        if users.count == 0 {
            return nil
        }
        
    } catch {}
    return users[0]
}
