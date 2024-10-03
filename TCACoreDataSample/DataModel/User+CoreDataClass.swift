//
//  User+CoreDataClass.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID()
    }

}
