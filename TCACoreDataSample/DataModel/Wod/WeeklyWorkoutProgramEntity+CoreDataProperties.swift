//
//  WeeklyWorkoutProgramEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension WeeklyWorkoutProgramEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeeklyWorkoutProgramEntity> {
        return NSFetchRequest<WeeklyWorkoutProgramEntity>(entityName: "WeeklyWorkoutProgramEntity")
    }

    @NSManaged public var expectedMinutes: Int16
    @NSManaged public var maxExpectedCalories: Int16
    @NSManaged public var minExpectedCalories: Int16
    @NSManaged public var subTitle: String
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var workOutInfos: NSSet

}

// MARK: Generated accessors for workOutInfos
extension WeeklyWorkoutProgramEntity {

    @objc(addWorkOutInfosObject:)
    @NSManaged public func addToWorkOutInfos(_ value: WorkOutInfoEntity)

    @objc(removeWorkOutInfosObject:)
    @NSManaged public func removeFromWorkOutInfos(_ value: WorkOutInfoEntity)

    @objc(addWorkOutInfos:)
    @NSManaged public func addToWorkOutInfos(_ values: NSSet)

    @objc(removeWorkOutInfos:)
    @NSManaged public func removeFromWorkOutInfos(_ values: NSSet)

}

extension WeeklyWorkoutProgramEntity : Identifiable {

}
