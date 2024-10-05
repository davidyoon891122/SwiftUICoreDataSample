//
//  WeeklyWorkoutProgramModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WeeklyWorkoutProgramModel: Equatable {
    let type: String
    let title: String
    let subTitle: String
    let expectedMinutes: Int
    let minExpectedCalories: Int
    let maxExpectedCalories: Int
    let workoutInfos: [WorkOutInfoModel]

    init(entity: WeeklyWorkoutProgramEntity) {
        self.type = entity.type
        self.title = entity.title
        self.subTitle = entity.subTitle
        self.expectedMinutes = Int(entity.expectedMinutes)
        self.minExpectedCalories = Int(entity.minExpectedCalories)
        self.maxExpectedCalories = Int(entity.maxExpectedCalories)
        self.workoutInfos = entity.workOutInfos.map {
            WorkOutInfoModel(entity: $0 as! WorkOutInfoEntity)
        }
    }
}
