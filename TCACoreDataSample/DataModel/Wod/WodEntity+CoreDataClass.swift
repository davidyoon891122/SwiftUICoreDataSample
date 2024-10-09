//
//  WorkOutItemEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WodEntity)
public class WodEntity: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

extension WodEntity {

    static func createWorkoutItemEntity(with context: NSManagedObjectContext, models: [WorkOutItemModel]) -> [WodEntity] {
        models.map { model in
            let newItem = WodEntity(context: context)
            newItem.id = model.id
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.unit = model.unit.rawValue
            newItem.unitValue = Int16(model.unitValue)
            newItem.set = Int16(model.set)
            let wodSet = WodSetEntity.createWodSetEntity(with: context, models: model.wodSet)
            newItem.wodSet = Set(wodSet)
            return newItem
        }
    }
    
    static func convertModelToEntity(with context: NSManagedObjectContext, model: WorkOutItemModel) -> WodEntity {
        let newItem = WodEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.unit = model.unit.rawValue
        newItem.unitValue = Int16(model.unitValue)
        newItem.set = Int16(model.set)
        newItem.wodSet = Set(WodSetEntity.createWodSetEntity(with: context, models: model.wodSet))
        
        return newItem
    }

}
