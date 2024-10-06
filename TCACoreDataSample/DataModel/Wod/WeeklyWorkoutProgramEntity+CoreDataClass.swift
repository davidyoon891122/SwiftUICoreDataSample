//
//  WeeklyWorkoutProgramEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//
//

import Foundation
import CoreData

@objc(WeeklyWorkoutProgramEntity)
public class WeeklyWorkoutProgramEntity: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }

}
