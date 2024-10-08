//
//  WorkOutItemEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension WodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WodEntity> {
        return NSFetchRequest<WodEntity>(entityName: "WorkOutItemEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var set: Int16
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var unit: String
    @NSManaged public var unitValue: Int16
    @NSManaged public var wodSet: Set<WodSetEntity>

}

// MARK: Generated accessors for wodSet
extension WodEntity {

    @objc(addWodSetObject:)
    @NSManaged public func addToWodSet(_ value: WodSetEntity)

    @objc(removeWodSetObject:)
    @NSManaged public func removeFromWodSet(_ value: WodSetEntity)

    @objc(addWodSet:)
    @NSManaged public func addToWodSet(_ values: NSSet)

    @objc(removeWodSet:)
    @NSManaged public func removeFromWodSet(_ values: NSSet)

}

extension WodEntity : Identifiable {

}
