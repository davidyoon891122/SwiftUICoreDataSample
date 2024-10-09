//
//  DayWorkoutEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension DayWorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayWorkoutEntity> {
        return NSFetchRequest<DayWorkoutEntity>(entityName: "DayWorkoutEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var type: String
    @NSManaged public var wods: NSOrderedSet

}

// MARK: Generated accessors for workOutItem
extension DayWorkoutEntity {

    @objc(addWorkOutItemObject:)
    @NSManaged public func addToWorkOutItem(_ value: WodEntity)

    @objc(removeWorkOutItemObject:)
    @NSManaged public func removeFromWorkOutItem(_ value: WodEntity)

    @objc(addWorkOutItem:)
    @NSManaged public func addToWorkOutItem(_ values: NSSet)

    @objc(removeWorkOutItem:)
    @NSManaged public func removeFromWorkOutItem(_ values: NSSet)

}

extension DayWorkoutEntity : Identifiable {

}
