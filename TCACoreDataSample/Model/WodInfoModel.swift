//
//  WodInfoModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WodInfoModel: Equatable {
    let methodType: String
    let level: String
    let weeklyWorkoutPrograms: [WeeklyWorkoutProgramModel]

    init(entity: WodInfoEntity) {
        self.methodType = entity.methodType
        self.level = entity.level
        self.weeklyWorkoutPrograms = entity.weeklyWorkoutProgram.map {
            WeeklyWorkoutProgramModel(entity: $0 as! WeeklyWorkoutProgramEntity)
        }
    }
}
