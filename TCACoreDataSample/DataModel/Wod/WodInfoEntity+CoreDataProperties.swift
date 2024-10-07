//
//  WodInfoEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension WodInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WodInfoEntity> {
        return NSFetchRequest<WodInfoEntity>(entityName: "WodInfoEntity")
    }

    @NSManaged public var level: String
    @NSManaged public var methodType: String
    @NSManaged public var weeklyWorkoutProgram: Set<WeeklyWorkoutProgramEntity>

}

// MARK: Generated accessors for weeklyWorkoutProgram
extension WodInfoEntity {

    @objc(addWeeklyWorkoutProgramObject:)
    @NSManaged public func addToWeeklyWorkoutProgram(_ value: WeeklyWorkoutProgramEntity)

    @objc(removeWeeklyWorkoutProgramObject:)
    @NSManaged public func removeFromWeeklyWorkoutProgram(_ value: WeeklyWorkoutProgramEntity)

    @objc(addWeeklyWorkoutProgram:)
    @NSManaged public func addToWeeklyWorkoutProgram(_ values: NSSet)

    @objc(removeWeeklyWorkoutProgram:)
    @NSManaged public func removeFromWeeklyWorkoutProgram(_ values: NSSet)

}

extension WodInfoEntity : Identifiable {

}
