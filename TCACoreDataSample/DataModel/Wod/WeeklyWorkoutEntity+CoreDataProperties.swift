//
//  WeeklyWorkoutProgramEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension WeeklyWorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeeklyWorkoutEntity> {
        return NSFetchRequest<WeeklyWorkoutEntity>(entityName: "WeeklyWorkoutEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var expectedMinutes: Int16
    @NSManaged public var maxExpectedCalories: Int16
    @NSManaged public var minExpectedCalories: Int16
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var dayWorkouts: NSOrderedSet

}

// MARK: Generated accessors for workOutInfos
extension WeeklyWorkoutEntity {

    @objc(addWorkOutInfosObject:)
    @NSManaged public func addToWorkOutInfos(_ value: DayWorkoutEntity)

    @objc(removeWorkOutInfosObject:)
    @NSManaged public func removeFromWorkOutInfos(_ value: DayWorkoutEntity)

    @objc(addWorkOutInfos:)
    @NSManaged public func addToWorkOutInfos(_ values: NSSet)

    @objc(removeWorkOutInfos:)
    @NSManaged public func removeFromWorkOutInfos(_ values: NSSet)

}

extension WeeklyWorkoutEntity : Identifiable {

}
