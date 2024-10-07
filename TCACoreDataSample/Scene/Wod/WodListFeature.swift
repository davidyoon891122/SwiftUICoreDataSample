//
//  WodListFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/6/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WodListFeature {

    @ObservableState
    struct State: Equatable {
        let id: UUID
        var wodStates: IdentifiedArrayOf<WodFeature.State> = []
    }

    enum Action {
        case onAppear
        case wodActions(id: WodFeature.State.ID, action: WodFeature.Action)
        case getAllWodStates(Result<[WodFeature.State], Error>)
    }

    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { [id = state.id] send in
                    do {
                        let wodStates = try wodClient.wodStates(id)
                        await send(.getAllWodStates(.success(wodStates)))
                    } catch {
                        await send(.getAllWodStates(.failure(error)))
                    }
                }
            case .wodActions:
                return .none

            case .getAllWodStates(.success(let wodStates)):
                state.wodStates = IdentifiedArray(uniqueElements: wodStates)
                return .none
            case .getAllWodStates(.failure(let error)):
                state.wodStates = []
                return .none
            }
        }
        .forEach(\.wodStates, action: /Action.wodActions(id:action:)) {
            WodFeature()
        }
    }

}

import SwiftUI
struct WodListView: View {

    let store: StoreOf<WodListFeature>

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEachStore(store.scope(state: \.wodStates, action: \.wodActions)) { store in
                        WodView(store: store)
                    }                    
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }

}

#Preview {
    WodListView(store: Store(initialState: WodListFeature.State(id: UUID())) {
        WodListFeature()
    })
}
