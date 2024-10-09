//
//  WorkOutInfoModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WorkOutInfoModel: Equatable {

    let id: UUID
    let type: WorkOutType
    var workOutItems: [WorkOutItemModel]

    init(entity: DayWorkoutEntity) {
        self.type = WorkOutType(rawValue: entity.type) ?? .coolDown
        self.workOutItems = entity.wods.map {
            WorkOutItemModel(entity: $0)
        }
        self.id = entity.id
    }

    init(id: UUID, type: WorkOutType, workOutItems: [WorkOutItemModel]) {
        self.id = id
        self.type = type
        self.workOutItems = workOutItems
    }

}

extension WorkOutInfoModel {

    static let preview: Self = .init(id: UUID(), type: .warmUp, workOutItems: [
        .init(id: UUID(), title: "트레드밀", subTitle: "lowing abc", unit: .minutes, unitValue: 5, set: 1, wodSet: [
            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false)
        ]),
        .init(id: UUID(), title: "시티드 덤벨 바이셉스 컬", subTitle: "lowing abc", unit: .repetitions, unitValue: 12, set: 2, wodSet: [
            .init(id: UUID(), order: 1, unitValue: 1, isCompleted: false),
            .init(id: UUID(), order: 2, unitValue: 2, isCompleted: false)
        ])
    ])

}

enum WorkOutType: String, Codable {

    case warmUp
    case main
    case coolDown

}

extension WorkOutType {

    var title: String {
        switch self {
        case .warmUp:
            return "Warm-Up"
        case .main:
            return "Main WOD"
        case .coolDown:
            return "Cool Down"
        }
    }

}
