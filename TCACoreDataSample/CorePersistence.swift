//
//  CorePersistence.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import CoreData

struct CorePersistenceController {

    static let shared = CorePersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: Constants.dbName)

        if inMemory {
            self.container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        self.container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        })

        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }


    @MainActor
    static let preview: CorePersistenceController = {
        let result = CorePersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        for _ in 0..<10 {
            let newItem = User(context: viewContext)
            newItem.name = "David"
            newItem.age = 34
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

}

extension CorePersistenceController {

    enum Constants {
        static let dbName = "MyCoreData"
    }

}
