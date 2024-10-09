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

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }

}

extension ProgramsEntity {

    static func instance(with context: NSManagedObjectContext, model: WodInfoModel) -> ProgramsEntity {
        let newWodInfoEntity = ProgramsEntity(context: context)
        newWodInfoEntity.id = model.id
        newWodInfoEntity.level = model.level.rawValue
        newWodInfoEntity.methodType = model.methodType.rawValue
        let weeklyWorkoutProgram = WeeklyWorkoutEntity.createProgramEntities(with: context, programModel: model.weeklyWorkoutPrograms)
        newWodInfoEntity.weeklyWorkouts = Set(weeklyWorkoutProgram)

        return newWodInfoEntity
    }

}
