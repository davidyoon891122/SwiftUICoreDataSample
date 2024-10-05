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

extension User {

    static func instance(from user: UserFeature.State, with context: NSManagedObjectContext) -> User {
        let newUserItem = User(context: context)
        newUserItem.name = user.name
        newUserItem.age = Int64(user.age)

        return newUserItem
    }

}
