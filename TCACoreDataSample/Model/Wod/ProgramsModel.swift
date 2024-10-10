//
//  ProgramsModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct ProgramsModel: Equatable {

    let id: UUID
    let methodType: ProgramMethodType
    let level: LevelType
    let weeklyWorkouts: [WeeklyWorkoutModel]

    init(entity: ProgramsEntity) {
        self.id = entity.id
        self.methodType = ProgramMethodType(rawValue: entity.methodType) ?? .body
        self.level = LevelType(rawValue: entity.level) ?? .beginner
        self.weeklyWorkouts = entity.weeklyWorkouts.map {
            WeeklyWorkoutModel(entity: $0 as! WeeklyWorkoutEntity)
        }
    }

    init(id: UUID, methodType: ProgramMethodType, level: LevelType, weeklyWorkoutPrograms: [WeeklyWorkoutModel]) {
        self.id = id
        self.methodType = methodType
        self.level = level
        self.weeklyWorkouts = weeklyWorkoutPrograms
    }

}

extension ProgramsModel {

    static let mock: Self = .init(id: UUID(), methodType: .body, level: .beginner, weeklyWorkoutPrograms: [
        .init(id: UUID(),
              type: .start,
              title: "알파 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalories: 445,
              maxExpectedCalories: 550,
              workoutInfos: [
                .init(id: UUID(), type: .warmUp, workOutItems: [
                    .init(id: UUID(),
                          title: "트레드밀",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 1,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "시티드 덤벨 바이셉스 컬",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, workOutItems: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, workOutItems: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "타이탄 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalories: 445,
              maxExpectedCalories: 550,
              workoutInfos: [
                .init(id: UUID(), type: .warmUp, workOutItems: [
                    .init(id: UUID(),
                          title: "트레드밀",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 1,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "시티드 덤벨 바이셉스 컬",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, workOutItems: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, workOutItems: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "히어로 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalories: 445,
              maxExpectedCalories: 550,
              workoutInfos: [
                .init(id: UUID(), type: .warmUp, workOutItems: [
                    .init(id: UUID(),
                          title: "트레드밀",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 1,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "시티드 덤벨 바이셉스 컬",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, workOutItems: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, workOutItems: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "블레디즈 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalories: 445,
              maxExpectedCalories: 550,
              workoutInfos: [
                .init(id: UUID(), type: .warmUp, workOutItems: [
                    .init(id: UUID(),
                          title: "트레드밀",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 1,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "시티드 덤벨 바이셉스 컬",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, workOutItems: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, workOutItems: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .default,
              title: "피닉스 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalories: 445,
              maxExpectedCalories: 550,
              workoutInfos: [
                .init(id: UUID(), type: .warmUp, workOutItems: [
                    .init(id: UUID(),
                          title: "트레드밀",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 1,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "시티드 덤벨 바이셉스 컬",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, workOutItems: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, workOutItems: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ]),
        .init(id: UUID(),
              type: .end,
              title: "에이펙스 데이",
              subTitle: "한 주를 힘차게 시작하는",
              expectedMinutes: 60,
              minExpectedCalories: 445,
              maxExpectedCalories: 550,
              workoutInfos: [
                .init(id: UUID(), type: .warmUp, workOutItems: [
                    .init(id: UUID(),
                          title: "트레드밀",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 1,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "시티드 덤벨 바이셉스 컬",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .main, workOutItems: [
                    .init(id: UUID(),
                          title: "체스트 프레스 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "힙 어브덕터/애덕터 머신",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 12,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "로우 러시안 트위스트",
                          subTitle: "lowing abc",
                          unit: .repetitions,
                          unitValue: 30,
                          set: 3,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false),
                            .init(id: UUID(), order: 3, unitValue: 3, isCompleted: false)
                          ]),
                ]),
                .init(id: UUID(), type: .coolDown, workOutItems: [
                    .init(id: UUID(),
                          title: "엘립티컬 머신",
                          subTitle: "lowing abc",
                          unit: .minutes,
                          unitValue: 5,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                    .init(id: UUID(),
                          title: "타이거 크롤",
                          subTitle: "lowing abc",
                          unit: .seconds,
                          unitValue: 20,
                          set: 2,
                          wodSet: [
                            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
                            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
                          ]),
                ])
              ])
    ])
}


enum ProgramMethodType: String, Codable {
    case body
    case machine

    var title: String {
        switch self {
        case .body:
            "맨몸 위주 운동"
        case .machine:
            "머신 위주 운동"
        }
    }

    var description: String {
        switch self {
        case .body:
            """
            초보자부터 고급자까지 누구나 수행할 수 있는 운동이에요. 전신의 근력을 강화할 뿐만 아니라, 유연성, 균형 감각, 심폐 지구력 등 다양한 신체 기능을 종합적으로 향상시킬 수 있어요.
            \n
            맨몸 운동은 부상 위험이 낮으며, 체력 수준에 맞게 난이도를 조절할 수 있어 꾸준한 운동 습관을 들이기에도 좋아요.
            """
        case .machine:
            """
            다양한 헬스장 기구와 머신을 이용해 근육을 자극하는 운동이에요.
            \n
            안정적인 근력 운동을 원하는 사람들에게 적합하며, 기구의 안전장치를 통해 고중량 운동을 안전하게 수행할 수 있어 근력 향상을 목표로 하는 사람들에게 이상적이에요. 부상 위험이 적어 경험이 적은 사용자에게도 좋아요.
            """
        }
    }
}


enum LevelType: String, Codable, CaseIterable {

    case beginner
    case elementary
    case intermediate
    case advanced

    var title: String {
        switch self {
        case .beginner:
            "입문"
        case .elementary:
            "초급"
        case .intermediate:
            "중급"
        case .advanced:
            "고급"
        }
    }

    var description: String {
        switch self {
        case .beginner:
            "기초 운동을 배우는 것이 목표에요"
        case .elementary:
            "체력을 향상시키고 복합 운동을 시작하는 단계에요"
        case .intermediate:
            "복합적인 웨이트 리프팅을 다룰 수 있어요"
        case .advanced:
            "고난도 동작과 고중량을 다룰 수 있어요"
        }
    }

}
