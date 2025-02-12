//
//  PersistenceController.swift
//  MatchMate
//
//  Created by Vishal Singh Solanki on 13/02/25.
//

import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ActivityData") 
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
}
