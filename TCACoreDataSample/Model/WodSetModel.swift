//
//  WodSetModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WodSetModel: Equatable, Hashable {

    let unitValue: Int
    let isCompleted: Bool

    init(entity: WodSetEntity) {
        self.unitValue = Int(entity.unitValue)
        self.isCompleted = entity.isCompleted
    }

    init(unitValue: Int, isCompleted: Bool) {
        self.unitValue = unitValue
        self.isCompleted = isCompleted
    }

}
