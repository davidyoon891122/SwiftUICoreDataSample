//
//  CoreData.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import CoreData

final class CoreData {

    static let shared = CoreData()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.dbName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print(error)
            }
        })

        return container
    }()

    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

}

extension CoreData {

    func fetchRequest() -> NSFetchRequest<User> {
        let request = NSFetchRequest<User>(entityName: "User")
        request.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]

        return request
    }

    enum Constants {
        static let dbName = "MyCoreData"
    }

}
