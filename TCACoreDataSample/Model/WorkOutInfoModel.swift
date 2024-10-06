//
//  WorkOutInfoModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WorkOutInfoModel: Equatable {

    let type: WorkOutType
    let workOutItems: [WorkOutItemModel]

    init(entity: WorkOutInfoEntity) {
        self.type = WorkOutType(rawValue: entity.type) ?? .coolDown
        self.workOutItems = entity.workOutItem.map {
            WorkOutItemModel(entity: $0 as! WorkOutItemEntity)
        }
    }

    init(type: WorkOutType, workOutItems: [WorkOutItemModel]) {
        self.type = type
        self.workOutItems = workOutItems
    }

}

extension WorkOutInfoModel {

    static let preview: Self = .init(type: .warmUp, workOutItems: [
        .init(title: "트레드밀", subTitle: "lowing abc", unit: .minutes, unitValue: 5, set: 1, wodSet: [
            .init(unitValue: 1, isCompleted: false)
        ]),
        .init(title: "시티드 덤벨 바이셉스 컬", subTitle: "lowing abc", unit: .repetitions, unitValue: 12, set: 2, wodSet: [
            .init(unitValue: 1, isCompleted: false),
            .init(unitValue: 2, isCompleted: false)
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
