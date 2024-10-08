//
//  ProgramsEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData


extension ProgramsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgramsEntity> {
        return NSFetchRequest<ProgramsEntity>(entityName: "ProgramsEntity")
    }

    @NSManaged public var level: String
    @NSManaged public var methodType: String
    @NSManaged public var weeklyWorkouts: Set<WeeklyWorkoutEntity>

}

// MARK: Generated accessors for weeklyWorkoutProgram
extension ProgramsEntity {

    @objc(addWeeklyWorkoutProgramObject:)
    @NSManaged public func addToWeeklyWorkoutProgram(_ value: WeeklyWorkoutEntity)

    @objc(removeWeeklyWorkoutProgramObject:)
    @NSManaged public func removeFromWeeklyWorkoutProgram(_ value: WeeklyWorkoutEntity)

    @objc(addWeeklyWorkoutProgram:)
    @NSManaged public func addToWeeklyWorkoutProgram(_ values: NSSet)

    @objc(removeWeeklyWorkoutProgram:)
    @NSManaged public func removeFromWeeklyWorkoutProgram(_ values: NSSet)

}

extension ProgramsEntity : Identifiable {

}
