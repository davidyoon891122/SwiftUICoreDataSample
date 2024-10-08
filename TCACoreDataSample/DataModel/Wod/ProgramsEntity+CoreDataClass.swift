//
//  WodInfoEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(ProgramsEntity)
public class ProgramsEntity: NSManagedObject {

}

extension ProgramsEntity {

    static func instance(with context: NSManagedObjectContext, model: WodInfoModel) -> ProgramsEntity {
        let newWodInfoEntity = ProgramsEntity(context: context)
        newWodInfoEntity.level = model.level.rawValue
        newWodInfoEntity.methodType = model.methodType.rawValue
        let weeklyWorkoutProgram = WeeklyWorkoutEntity.createProgramEntities(with: context, programModel: model.weeklyWorkoutPrograms)
        newWodInfoEntity.weeklyWorkouts = Set(weeklyWorkoutProgram)

        return newWodInfoEntity
    }

}
