//
//  WorkOutInfoEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension WorkOutInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkOutInfoEntity> {
        return NSFetchRequest<WorkOutInfoEntity>(entityName: "WorkOutInfoEntity")
    }

    @NSManaged public var type: String
    @NSManaged public var workOutItem: NSSet

}

// MARK: Generated accessors for workOutItem
extension WorkOutInfoEntity {

    @objc(addWorkOutItemObject:)
    @NSManaged public func addToWorkOutItem(_ value: WorkOutItemEntity)

    @objc(removeWorkOutItemObject:)
    @NSManaged public func removeFromWorkOutItem(_ value: WorkOutItemEntity)

    @objc(addWorkOutItem:)
    @NSManaged public func addToWorkOutItem(_ values: NSSet)

    @objc(removeWorkOutItem:)
    @NSManaged public func removeFromWorkOutItem(_ values: NSSet)

}

extension WorkOutInfoEntity : Identifiable {

}
