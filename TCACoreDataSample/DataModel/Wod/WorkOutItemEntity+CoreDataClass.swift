//
//  WorkOutItemEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WorkOutItemEntity)
public class WorkOutItemEntity: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

extension WorkOutItemEntity {

    static func createWorkoutItemEntity(with context: NSManagedObjectContext, models: [WorkOutItemModel]) -> [WorkOutItemEntity] {
        models.map { model in
            let newItem = WorkOutItemEntity(context: context)
            newItem.id = UUID()
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.unit = model.unit.rawValue
            newItem.unitValue = Int16(model.unitValue)
            newItem.set = Int16(model.set)
            let wodSet = WodSetEntity.createWodSetEntity(with: context, models: model.wodSet)
            newItem.wodSet = NSSet(array: wodSet)
            return newItem
        }
    }

}
