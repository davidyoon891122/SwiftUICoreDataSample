//
//  RecentCompletedWodEntity+CoreDataProperties.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/9/24.
//
//

import Foundation
import CoreData


extension RecentCompletedWodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentCompletedWodEntity> {
        return NSFetchRequest<RecentCompletedWodEntity>(entityName: "RecentCompletedWodEntity")
    }

    @NSManaged public var title: String
    @NSManaged public var date: String
    @NSManaged public var duration: Int64
    @NSManaged public var id: UUID
    @NSManaged public var weeklyWorkout: WeeklyWorkoutEntity

}

extension RecentCompletedWodEntity : Identifiable {
    
    static func instance(with context: NSManagedObjectContext, model: RecentCompletedWodModel) -> RecentCompletedWodEntity {
        let newItem = RecentCompletedWodEntity(context: context)
        newItem.id = model.id
        newItem.date = model.date
        newItem.duration = Int64(model.duration)
        newItem.title = model.title
        newItem.weeklyWorkout = WeeklyWorkoutEntity.convertToEntity(with: context, model: model.weeklyWorkout)
        
        return newItem
    }
    
}
