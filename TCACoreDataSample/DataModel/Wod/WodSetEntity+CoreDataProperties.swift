//
//  WodSetEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension WodSetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WodSetEntity> {
        return NSFetchRequest<WodSetEntity>(entityName: "WodSetEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var isCompleted: Bool
    @NSManaged public var unitValue: Int16
    @NSManaged public var order: Int16

}

extension WodSetEntity : Identifiable {

}
