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
    
}
