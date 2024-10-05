//
//  WorkOutInfoModel.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation

struct WorkOutInfoModel: Equatable {

    let type: String
    let workOutItems: [WorkOutItemModel]

    init(entity: WorkOutInfoEntity) {
        self.type = entity.type
        self.workOutItems = entity.workOutItem.map {
            WorkOutItemModel(entity: $0 as! WorkOutItemEntity)
        }
    }

}
