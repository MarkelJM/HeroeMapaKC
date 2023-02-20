//
//  CoreDataManager.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 20/2/23.
//

import CoreData

class CoredataManager {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores{_ , error in
            if let error {
                debugPrint("Error during loading persistent stores \(error)")
            }
            
        }
        return container
    }()
    
    lazy var manageContext : NSManagedObjectContext = self.storeContainer.viewContext
    
    func saveContext(){
        guard manageContext.hasChanges else {return}
        
        do {
            
        } catch let error as NSError{
            debugPrint("Error during saving context \(error)")
        }
    }
    
}
