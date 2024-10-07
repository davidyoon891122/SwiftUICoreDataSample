//
//  WorkOutItemModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WorkOutItemModel: Equatable, Identifiable {

    let id: UUID
    let title: String
    let subTitle: String
    let unit: ExerciseUnit
    let unitValue: Int
    let set: Int
    var wodSet: [WodSetModel]

    init(entity: WorkOutItemEntity) {
        self.id = entity.id
        self.title = entity.title
        self.subTitle = entity.subTitle
        self.unit = ExerciseUnit(rawValue: entity.unit) ?? .seconds
        self.unitValue = Int(entity.unitValue)
        self.set = Int(entity.set)
        self.wodSet = entity.wodSet.map { WodSetModel(entity: $0 as! WodSetEntity) }
    }

    init(id: UUID, title: String, subTitle: String, unit: ExerciseUnit, unitValue: Int, set: Int, wodSet: [WodSetModel]) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.unit = unit
        self.unitValue = unitValue
        self.set = set
        self.wodSet = wodSet
    }

}

enum ExerciseUnit: String, Codable {

    case seconds
    case minutes
    case repetitions

}

extension ExerciseUnit {

    var title: String {
        switch self {
        case .seconds:
            return "초 (Sec)" // Q: 초에 대한 기획.
        case .minutes:
            return "분 (Min)"
        case .repetitions:
            return "회 (rep)"
        }
    }

}
