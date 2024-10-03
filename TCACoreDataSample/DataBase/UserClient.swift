//
//  UserClient.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import Foundation
import ComposableArchitecture

struct UserClient {
    var all: () throws -> [UserFeature.State]
    var add: (_ userState: UserFeature.State) throws -> UserAddResponse
    var remove: (_ userStates: [UserFeature.State]) throws -> UserRemoveResponse
}

extension UserClient: DependencyKey {

    static let liveValue = Self(all: {
        try CoreDataProvider.shared.getUserStates()
    }, add: { user in
        try CoreDataProvider.shared.addUser(user)
    }, remove: { users in
        try CoreDataProvider.shared.removeUser(users)
    })
}

extension DependencyValues {

    var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }

}

struct UserAddResponse: Equatable {
    let addedUser: UserFeature.State?
    let users: [UserFeature.State]
}

struct UserRemoveResponse: Equatable {
    let removedUser: [UserFeature.State]
    let users: [UserFeature.State]
}
