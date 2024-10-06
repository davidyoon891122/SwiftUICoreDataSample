//
//  WeeklyWorkoutProgramModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WeeklyWorkoutProgramModel: Equatable {

    let type: WorkOutDayTagType
    let title: String
    let subTitle: String
    let expectedMinutes: Int
    let minExpectedCalories: Int
    let maxExpectedCalories: Int
    let workoutInfos: [WorkOutInfoModel]

    init(entity: WeeklyWorkoutProgramEntity) {
        self.type = WorkOutDayTagType(rawValue: entity.type) ?? .default
        self.title = entity.title
        self.subTitle = entity.subTitle
        self.expectedMinutes = Int(entity.expectedMinutes)
        self.minExpectedCalories = Int(entity.minExpectedCalories)
        self.maxExpectedCalories = Int(entity.maxExpectedCalories)
        self.workoutInfos = entity.workOutInfos.map {
            WorkOutInfoModel(entity: $0 as! WorkOutInfoEntity)
        }
    }

    init(type: WorkOutDayTagType, title: String, subTitle: String, expectedMinutes: Int, minExpectedCalories: Int, maxExpectedCalories: Int, workoutInfos: [WorkOutInfoModel]) {
        self.type = type
        self.title = title
        self.subTitle = subTitle
        self.expectedMinutes = expectedMinutes
        self.minExpectedCalories = minExpectedCalories
        self.maxExpectedCalories = maxExpectedCalories
        self.workoutInfos = workoutInfos
    }

}

enum WorkOutDayTagType: String, Codable {

    case start
    case end
    case `default`

}

extension WorkOutDayTagType {

    var title: String? {
        switch self {
        case .start:
            return "start"
        case .end:
            return "final"
        default:
            return nil
        }
    }

}



extension WeeklyWorkoutProgramModel {

    static let preview: Self = .init(type: .start,
                                     title: "알파 데이",
                                     subTitle: "한 주를 힘차게 시작하는",
                                     expectedMinutes: 60,
                                     minExpectedCalories: 445,
                                     maxExpectedCalories: 550,
                                     workoutInfos: [
                                        .init(type: .warmUp, workOutItems: [
                                            .init(title: "트레드밀",
                                                  subTitle: "lowing abc",
                                                  unit: .minutes,
                                                  unitValue: 5,
                                                  set: 1,
                                                  wodSet: [
                                                    .init(unitValue: 1, isCompleted: false)
                                                  ]),
                                            .init(title: "시티드 덤벨 바이셉스 컬",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 2,
                                                  wodSet: [
                                                    .init(unitValue: 1, isCompleted: false),
                                                    .init(unitValue: 2, isCompleted: false)
                                                  ])
                                        ]),
                                        .init(type: .main, workOutItems: [
                                            .init(title: "체스트 프레스 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 3,
                                                  wodSet: [
                                                    .init(unitValue: 1, isCompleted: false),
                                                    .init(unitValue: 2, isCompleted: false),
                                                    .init(unitValue: 3, isCompleted: false)
                                                  ]),
                                            .init(title: "힙 어브덕터/애덕터 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 12,
                                                  set: 3,
                                                  wodSet: [
                                                    .init(unitValue: 1, isCompleted: false),
                                                    .init(unitValue: 2, isCompleted: false),
                                                    .init(unitValue: 3, isCompleted: false)
                                                  ]),
                                            .init(title: "로우 러시안 트위스트",
                                                  subTitle: "lowing abc",
                                                  unit: .repetitions,
                                                  unitValue: 30,
                                                  set: 3,
                                                  wodSet: [
                                                    .init(unitValue: 1, isCompleted: false),
                                                    .init(unitValue: 2, isCompleted: false),
                                                    .init(unitValue: 3, isCompleted: false)
                                                  ])
                                        ]),
                                        .init(type: .coolDown, workOutItems: [
                                            .init(title: "엘립티컬 머신",
                                                  subTitle: "lowing abc",
                                                  unit: .minutes,
                                                  unitValue: 5,
                                                  set: 2,
                                                  wodSet: [
                                                    .init(unitValue: 1, isCompleted: false),
                                                    .init(unitValue: 2, isCompleted: false)
                                                  ]),
                                            .init(title: "타이거 크롤",
                                                  subTitle: "lowing abc",
                                                  unit: .seconds,
                                                  unitValue: 20,
                                                  set: 2,
                                                  wodSet: [
                                                    .init(unitValue: 1, isCompleted: false),
                                                    .init(unitValue: 2, isCompleted: false)
                                                  ])
                                        ])
                                     ])
}
