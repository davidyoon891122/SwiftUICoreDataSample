//
//  WodCoreData.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import CoreData

final class WodCoreData {

    static let shared = WodCoreData()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "")

        container.loadPersistentStores(completionHandler: { _, error in

            if let error = error as NSError? {
                print("Load store error: \(error)")
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
                print("save changes error: \(error)")
            }
        }
    }

}

extension WodCoreData {

    func fetchRequest() -> NSFetchRequest<WodInfoEntity> {
        let request = NSFetchRequest<WodInfoEntity>(entityName: "WodInfoEntity")

        request.sortDescriptors = [NSSortDescriptor(key: "expectedMinutes", ascending: true)]

        return request
    }

}

