//
//  WodInfoEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WodInfoEntity)
public class WodInfoEntity: NSManagedObject {

}

extension WodInfoEntity {

    static func instance(with context: NSManagedObjectContext, model: WodInfoModel) -> WodInfoEntity {
        let newWodInfoEntity = WodInfoEntity(context: context)
        newWodInfoEntity.level = model.level.rawValue
        newWodInfoEntity.methodType = model.methodType.rawValue
        let weeklyWorkoutProgram = WeeklyWorkoutProgramEntity.createProgramEntities(with: context, programModel: model.weeklyWorkoutPrograms)
        newWodInfoEntity.weeklyWorkoutProgram = NSSet(array: weeklyWorkoutProgram)

        return newWodInfoEntity
    }

}
