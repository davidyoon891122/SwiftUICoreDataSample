//
//  UserListFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct UserListFeature {

    @ObservableState
    struct State: Equatable {
        var users: IdentifiedArrayOf<UserFeature.State> = []
    }

    enum Action {
        case onAppear
        case didTapAddUserButton
        case user(IdentifiedActionOf<UserFeature>)
        case getAllUsers(TaskResult<[UserFeature.State]>)
        case userAddResponse(TaskResult<UserAddResponse>)
        case userDeleteResponse(TaskResult<UserRemoveResponse>)
        case deleteUser(IndexSet)
    }

    @Dependency(\.userClient) var userClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        let users = try userClient.all()
                        await send(.getAllUsers(.success(users)))
                    } catch {
                        await send(.getAllUsers(.failure(error)))
                    }
                }
            case .user:
                return .none
            case .getAllUsers(.success(let users)):
                state.users = IdentifiedArrayOf(uniqueElements: users)
                return .none
            case .getAllUsers(.failure), .userAddResponse(.failure(_)), .userDeleteResponse(.failure(_)):
                return .none
            case .didTapAddUserButton:
                return .run { send in
                    let response = try userClient.add(UserFeature.State(name: "David", age: 36))
                    await send(.userAddResponse(.success(response)))
                }
            case .userAddResponse(.success(let response)):
                guard let addedUser = response.addedUser else {
                    return .none
                }

                state.users.insert(addedUser, at: 0)

                return .run { send in
                    do {
                        let users = try userClient.all()
                        await send(.getAllUsers(.success(users)))
                    } catch {
                        await send(.getAllUsers(.failure(error)))
                    }
                }
            case .deleteUser(let indexSet):
                let currentUsers = state.users
                var users: [UserFeature.State] = []

                for index in indexSet {
                    users.append(currentUsers[index])
                }

                let removedUsers = users

                return .run { send in
                    do {
                        let response = try userClient.remove(removedUsers)
                        await send(.userDeleteResponse(.success(response)))
                    } catch {
                        await send(.userDeleteResponse(.failure(error)))
                    }
                }
            case .userDeleteResponse(.success(let response)):
                let removedIds = response.removedUser.map { $0.id }
                removedIds.forEach { id in
                    state.users.remove(id: id)
                }

                let users = state.users.elements

                return .run { send in
                    await send(.getAllUsers(.success(users)))
                }
            }
        }
        .forEach(\.users, action: \.user) {
            UserFeature()
        }
    }

}

import SwiftUI
struct UserListView: View {

    let store: StoreOf<UserListFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                VStack {
                    ForEach(store.scope(state: \.users, action: \.user)) { store in
                        UserView(store: store)
                    }
                    .onDelete { indexSet in
                        store.send(.deleteUser(indexSet))
                    }
                }
                .onAppear {
                    store.send(.onAppear)
                }
                .navigationTitle("UserList")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }

                    ToolbarItem {
                        Button(action: {
                            store.send(.didTapAddUserButton)
                        }, label: {
                            Text("Add")
                        })
                    }
                }
            }
        }
    }
}


#Preview {
    UserListView(store: Store(initialState: UserListFeature.State()) {
        UserListFeature()
    })
}
