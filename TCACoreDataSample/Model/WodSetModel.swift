//
//  WodSetModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WodSetModel: Equatable, Hashable {

    let id: UUID
    let order: Int
    let unitValue: Int
    var isCompleted: Bool

    init(entity: WodSetEntity) {
        self.id = UUID()
        self.order = Int(entity.order)
        self.unitValue = Int(entity.unitValue)
        self.isCompleted = entity.isCompleted
    }

    init(order: Int, unitValue: Int, isCompleted: Bool) {
        self.id = UUID()
        self.order = order
        self.unitValue = unitValue
        self.isCompleted = isCompleted
    }

}
