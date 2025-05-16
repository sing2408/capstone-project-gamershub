//
//  PersistanceController.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 13/05/25.
//

import CoreData
import Foundation

public class PersistenceController: @unchecked Sendable {
    public static let shared = PersistenceController()
    
    let modelName: String
    
    public let container: NSPersistentContainer
    
    private init() {

        modelName = "GamersHubDataModel"
        
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "mom") else {

            fatalError("Failed to find model URL in framework bundle test.")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create managed object model from URL.")
        }
        
        container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
        
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load Core Data stack: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error saving context: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



