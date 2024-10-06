//
//  WorkOutInfoEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WorkOutInfoEntity)
public class WorkOutInfoEntity: NSManagedObject {

}

extension WorkOutInfoEntity {

    static func createWorkoutInfoEntities(with context: NSManagedObjectContext, models: [WorkOutInfoModel]) -> [WorkOutInfoEntity] {
        return models.map { model in
            let newItem = WorkOutInfoEntity(context: context)
            newItem.type = model.type.rawValue
            let workOutItem = WorkOutItemEntity.createWorkoutItemEntity(with: context, models: model.workOutItems)
            newItem.workOutItem = NSSet(array: workOutItem)
            return newItem
        }
    }

}
