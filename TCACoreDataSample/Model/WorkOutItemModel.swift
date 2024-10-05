//
//  WorkOutItemModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WorkOutItemModel: Equatable {

    let title: String
    let subTitle: String
    let unit: String
    let unitValue: Int
    let set: Int
    let wodSet: [WodSetModel]

    init(entity: WorkOutItemEntity) {
        self.title = entity.title
        self.subTitle = entity.subTitle
        self.unit = entity.unit
        self.unitValue = Int(entity.unitValue)
        self.set = Int(entity.set)
        self.wodSet = entity.wodSet.map { WodSetModel(entity: $0 as! WodSetEntity) }
    }

}
