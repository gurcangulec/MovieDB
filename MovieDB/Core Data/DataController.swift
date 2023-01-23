//
//  DataController.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 10.01.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let persistentStoreContainer: NSPersistentContainer
    static let shared = DataController()
    
    init() {
        persistentStoreContainer = NSPersistentContainer(name: "MovieDB")
        persistentStoreContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.persistentStoreContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
