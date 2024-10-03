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
        case user(id: UserFeature.State.ID, action: UserFeature.Action)
        case getAllUsers(TaskResult<[UserFeature.State]>)
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
            case .getAllUsers(.failure):
                return .none
            }
        }
    }

}

import SwiftUI
struct UserListView: View {

    let store: StoreOf<UserListFeature>

    var body: some View {
        VStack {
            List {
                ForEachStore(store.scope(state: \.users, action: UserListFeature.Action.user(id: action:))) { store in
                    UserView(store: store)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}


#Preview {
    UserListView(store: Store(initialState: UserListFeature.State()) {
        UserListFeature()
    })
}
