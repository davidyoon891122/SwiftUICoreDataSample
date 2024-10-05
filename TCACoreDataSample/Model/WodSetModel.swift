//
//  WodSetModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WodSetModel: Equatable {

    let unitValue: Int
    let isCompleted: Bool

    init(entity: WodSetEntity) {
        self.unitValue = Int(entity.unitValue)
        self.isCompleted = entity.isCompleted
    }

}
