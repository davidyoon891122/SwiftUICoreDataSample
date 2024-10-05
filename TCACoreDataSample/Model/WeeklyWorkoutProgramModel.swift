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
}
