//
//  WeeklyWorkoutEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WeeklyWorkoutEntity)
public class WeeklyWorkoutEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }

}

extension WeeklyWorkoutEntity {

    static func createProgramEntities(with context: NSManagedObjectContext, programModel: [WeeklyWorkoutModel]) -> [WeeklyWorkoutEntity] {
        programModel.map { model in
            let newItem = WeeklyWorkoutEntity(context: context)
            newItem.id = model.id
            newItem.type = model.type.rawValue
            newItem.title = model.title
            newItem.subTitle = model.subTitle
            newItem.expectedMinutes = Int64(model.expectedMinutes)
            newItem.minExpectedCalories = Int16(model.minExpectedCalories)
            newItem.maxExpectedCalories = Int16(model.maxExpectedCalories)
            let workOutInfos = DayWorkoutEntity.createWorkoutInfoEntities(with: context, models: model.workoutInfos)
            newItem.dayWorkouts = NSOrderedSet(array: workOutInfos)
            return newItem
        }
    }
    
    static func convertToEntity(with context: NSManagedObjectContext, model: WeeklyWorkoutModel) -> WeeklyWorkoutEntity {
        let newItem = WeeklyWorkoutEntity(context: context)
        newItem.id = model.id
        newItem.title = model.title
        newItem.subTitle = model.subTitle
        newItem.expectedMinutes = Int64(model.expectedMinutes)
        newItem.minExpectedCalories = Int16(model.minExpectedCalories)
        newItem.maxExpectedCalories = Int16(model.maxExpectedCalories)
        newItem.type = model.type.rawValue
        newItem.dayWorkouts = NSOrderedSet(array: DayWorkoutEntity.createWorkoutInfoEntities(with: context, models: model.workoutInfos))
        
        return newItem
    }

}
