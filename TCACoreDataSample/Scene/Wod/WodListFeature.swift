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
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                
                return .none
            case .wodActions:
                return .none
            }
        }
    }

}

import SwiftUI
struct WodListView: View {

    let store: StoreOf<WodListFeature>

    var body: some View {
        VStack {
            List {
                ForEachStore(store.scope(state: \.wodStates, action: \.wodActions)) { store in
                    WodView(store: store)
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
