//
//  CoreDataProvider.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import Foundation
import ComposableArchitecture

final class CoreDataProvider {

    static let shared = CoreDataProvider()

    private let context = CoreData.shared.context

    func getUserStates() throws -> [UserFeature.State] {
        let userStates = try self.getUserItems().map { UserFeature.State(with: $0) }

        return userStates
    }

    func addUser(_ userState: UserFeature.State) throws -> UserAddResponse {
        let hasUser = try hasUser(userState)

        guard !hasUser else {
            return UserAddResponse(addedUser: nil, users: try getUserStates())
        }

        let userItem = User.instance(from: userState, with: context)

        try context.save()

        return UserAddResponse(addedUser: UserFeature.State(with: userItem), users: try getUserStates())
    }

    func removeUser(_ userStates: [UserFeature.State]) throws -> UserRemoveResponse {

        var removedUsers: [UserFeature.State] = []

        try userStates.forEach { userState in
            let userItems = try getUserItems()
            if let itemId = userItems.filter({ $0.id == userState.id }).first?.objectID,
            let userItem = context.object(with: itemId) as? User {
                context.delete(userItem)
                removedUsers.append(userState)
            }
        }

        try context.save()

        return UserRemoveResponse(removedUser: removedUsers, users: try getUserStates())
    }

}

private extension CoreDataProvider {

    func getUserItems() throws -> [User] {
        var users = [User]()
        users = try context.fetch(CoreData.shared.fetchRequest())

        return users
    }

    func hasUser(_ userState: UserFeature.State) throws -> Bool {
        let user = try self.getUserItems().first { $0.id == userState.id }

        return user != nil
    }

}
