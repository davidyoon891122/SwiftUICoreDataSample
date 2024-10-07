//
//  WeeklyWorkoutProgramEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WeeklyWorkoutProgramEntity)
public class WeeklyWorkoutProgramEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }

}

extension WeeklyWorkoutProgramEntity {

    static func createProgramEntities(with context: NSManagedObjectContext, programModel: [WeeklyWorkoutProgramModel]) -> [WeeklyWorkoutProgramEntity] {
        programModel.map { model in
            let newItem = WeeklyWorkoutProgramEntity(context: context)
            newItem.type = model.type.rawValue
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.expectedMinutes = Int16(model.expectedMinutes)
            newItem.minExpectedCalories = Int16(model.minExpectedCalories)
            newItem.maxExpectedCalories = Int16(model.maxExpectedCalories)
            let workOutInfos = WorkOutInfoEntity.createWorkoutInfoEntities(with: context, models: model.workoutInfos)
            newItem.workOutInfos = Set(workOutInfos)
            return newItem
        }
    }

}
