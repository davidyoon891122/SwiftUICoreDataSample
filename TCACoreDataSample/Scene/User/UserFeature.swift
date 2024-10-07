//
//  UserFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct UserFeature {

    @ObservableState
    struct State: Equatable, Identifiable {
        var id: UUID
        var name: String = ""
        var age: Int = 0

        init(with user: User) {
            self.id = user.id
            self.name = user.name
            self.age = Int(user.age)
        }

        init(name: String, age: Int) {
            self.id = UUID()
            self.name = name
            self.age = age
        }
    }

    enum Action {
        case onAppear
        case didTapButton
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("OnAppear")
                return .none
            case .didTapButton:
                
                print("didTap button")
                return .none
            }
        }
    }

}

import SwiftUI
struct UserView: View {

    let store: StoreOf<UserFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack {
                HStack {
                    Text(store.name)
                    Spacer()
                    Text("\(store.age)")
                    Button(action: {
                        store.send(.didTapButton)
                    }, label: {
                        Text("didtap Button")
                    })
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }

}

#Preview {
    UserView(store: Store(initialState: UserFeature.State(name: "David", age: 36)) {
        UserFeature()
    })
}
