//
//  WodSetEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WodSetEntity)
public class WodSetEntity: NSManagedObject {

}

extension WodSetEntity {

    static func createWodSetEntity(with context: NSManagedObjectContext, models: [WodSetModel]) -> [WodSetEntity] {
        return models.map { model in
            let newItem = WodSetEntity(context: context)
            newItem.unitValue = Int16(model.unitValue)
            newItem.isCompleted = model.isCompleted

            return newItem
        }
    }

}
