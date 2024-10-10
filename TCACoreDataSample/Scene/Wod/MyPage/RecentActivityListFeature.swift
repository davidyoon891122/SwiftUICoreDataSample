//
//  RecentActivityListFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RecentActivityListFeature {

    @ObservableState
    struct State {
        var recentActivityState: IdentifiedArrayOf<RecentActivityFeature.State> = []
    }

    enum Action {
        case onAppear
        case recentActivityActions(IdentifiedActionOf<RecentActivityFeature>)
        case getAllRecentStates(Result<[RecentActivityFeature.State], Error>)
    }

    
    @Dependency(\.wodClient) var wodClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        let recentStates = try wodClient.recentCompletedWodStates()
                        await send(.getAllRecentStates(.success(recentStates)))
                    } catch {
                        await send(.getAllRecentStates(.failure(error)))
                    }
                    
                }
            case .recentActivityActions:
                return .none
            case .getAllRecentStates(.success(let result)):
                state.recentActivityState = IdentifiedArray(uniqueElements: result)
                return .none
            case .getAllRecentStates(.failure(let error)):
                print(error)
                return .none
            }
        }
        .forEach(\.recentActivityState, action: \.recentActivityActions) {
            RecentActivityFeature()
        }
    }

}

import SwiftUI
struct RecentActivityListView: View {
    
    let store: StoreOf<RecentActivityListFeature>

    var body: some View {
        VStack(alignment: .leading) {
            Text("최근 활동")
            ForEach(store.scope(state: \.recentActivityState, action: \.recentActivityActions)) { store in
                RecentActivityView(store: store)
            }
        }
    }
    
}

#Preview {
    RecentActivityListView(store: Store(initialState: RecentActivityListFeature.State()) {
        RecentActivityListFeature()
    })
}
