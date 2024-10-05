//
//  WorkOutItemEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension WorkOutItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkOutItemEntity> {
        return NSFetchRequest<WorkOutItemEntity>(entityName: "WorkOutItemEntity")
    }

    @NSManaged public var set: Int16
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var unit: String
    @NSManaged public var unitValue: Int16
    @NSManaged public var wodSet: NSSet

}

// MARK: Generated accessors for wodSet
extension WorkOutItemEntity {

    @objc(addWodSetObject:)
    @NSManaged public func addToWodSet(_ value: WodSetEntity)

    @objc(removeWodSetObject:)
    @NSManaged public func removeFromWodSet(_ value: WodSetEntity)

    @objc(addWodSet:)
    @NSManaged public func addToWodSet(_ values: NSSet)

    @objc(removeWodSet:)
    @NSManaged public func removeFromWodSet(_ values: NSSet)

}

extension WorkOutItemEntity : Identifiable {

}
