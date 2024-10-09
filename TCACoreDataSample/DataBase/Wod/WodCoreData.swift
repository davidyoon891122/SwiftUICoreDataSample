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
        let container = NSPersistentContainer(name: Constants.dbName)

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

    func fetchRequest() -> NSFetchRequest<ProgramsEntity> {
        let request = NSFetchRequest<ProgramsEntity>(entityName: Constants.entityName)

        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]

        return request
    }

    func fetchRecentCompletedWods() -> NSFetchRequest<RecentCompletedWodEntity> {
        let request = NSFetchRequest<RecentCompletedWodEntity>(entityName: Constants.recentEntityName)

        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]

        return request
    }

    enum Constants {
        static let dbName = "WodCoreDataSample"
        static let entityName = "ProgramsEntity"
        static let recentEntityName = "RecentCompletedWodEntity"
    }

}

