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
        let title: String
        var wodStates: IdentifiedArrayOf<WodFeature.State> = []
    }

    enum Action {
        case onAppear
        case wodActions(IdentifiedActionOf<WodFeature>)
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
        .forEach(\.wodStates, action: \.wodActions) {
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
                VStack {
                    ForEach(store.scope(state: \.wodStates, action: \.wodActions)) { store in
                        WodView(store: store)
                    }                    
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .navigationTitle(store.state.title)
    }

}

#Preview {
    WodListView(store: Store(initialState: WodListFeature.State(id: UUID(), title: "Title")) {
        WodListFeature()
    })
}
