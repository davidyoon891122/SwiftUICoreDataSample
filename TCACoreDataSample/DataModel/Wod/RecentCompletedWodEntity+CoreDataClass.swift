//
//  RecentCompletedWodEntity+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/9/24.
//
//

import Foundation
import CoreData

@objc(RecentCompletedWodEntity)
public class RecentCompletedWodEntity: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }
    
}
