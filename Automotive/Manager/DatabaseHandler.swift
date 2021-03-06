//
//  DatabaseHandler.swift
//  Automotive
//
//  Created by Mac on 5/1/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHandler: NSObject {

    private override init() {
        
    }
    
    class func getContext() -> NSManagedObjectContext {
        return DatabaseHandler.persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Automotive")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Favourites Delete, Get Value
    
    class func favValue(favID: Int) -> Favourites? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
        let predicate = NSPredicate(format: "id == %ld", favID)
        fetchRequest.predicate = predicate
        
        do {
            let searchResult = try DatabaseHandler.getContext().fetch(fetchRequest) as? [Favourites]
            if searchResult!.count > 0 {
                return searchResult![0]
            }
        } catch {
            print("Error")
            return nil
        }
        
        return nil
    }
    
    class func deleteContext(favID: Int) {
        guard let result = DatabaseHandler.favValue(favID: favID) else{ return }
        DatabaseHandler.getContext().delete(result)
        DatabaseHandler.saveContext()
    }
    
    class func favExist(favID: Int) -> Bool {
        guard DatabaseHandler.favValue(favID: favID) != nil else { return false }
        return true
    }
    
    class func totalFav() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
        do {
            let searchResult = try DatabaseHandler.getContext().fetch(fetchRequest) as? [Favourites]
            return (searchResult?.count)!
        } catch {
            return 0
        }
    }
}
