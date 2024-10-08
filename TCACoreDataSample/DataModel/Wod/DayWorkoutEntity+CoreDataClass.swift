//
//  WorkOutInfoEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(DayWorkoutEntity)
public class DayWorkoutEntity: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
}

extension DayWorkoutEntity {

    static func createWorkoutInfoEntities(with context: NSManagedObjectContext, models: [WorkOutInfoModel]) -> [DayWorkoutEntity] {
        return models.map { model in
            let newItem = DayWorkoutEntity(context: context)
            newItem.type = model.type.rawValue
            let workOutItem = WodEntity.createWorkoutItemEntity(with: context, models: model.workOutItems)
            newItem.wods = Set(workOutItem)
            return newItem
        }
    }

}
