//
//  WodListProgramFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/6/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WodListProgramFeature {

    @ObservableState
    struct State: Equatable {
        var wodProgramStates: IdentifiedArrayOf<WodProgramFeature.State> = []
        var path = StackState<WodListFeature.State>()
    }

    enum Action {
        case onAppear
        case wodProgramActions(id: WodProgramFeature.State.ID, action: WodProgramFeature.Action)
        case getAllProgramStates(Result<[WodProgramFeature.State], Error>)
        case didTapAddProgramButton
        case wodAddResponse(Result<[WodProgramFeature.State], Error>)
        case path(StackAction<WodListFeature.State, WodListFeature.Action>)
        case didTapProgramView(UUID)
    }

    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        let programStates = try wodClient.wodPrograms()
                        await send(.getAllProgramStates(.success(programStates)))
                    } catch {
                        await send(.getAllProgramStates(.failure(error)))
                    }
                }
            case .wodProgramActions:
                return .none

            case .getAllProgramStates(.success(let programStates)):
                state.wodProgramStates = IdentifiedArrayOf(uniqueElements: programStates)
                return .none

            case .getAllProgramStates(.failure(let error)):
                state.wodProgramStates = []
                return .none
            case .didTapAddProgramButton:
                return .run { send in
                    do {
                        let response = try wodClient.addWodProgram()
                        await send(.wodAddResponse(.success(response.programStates)))
                    } catch {
                        await send(.wodAddResponse(.failure(error)))
                    }
                }
            case .wodAddResponse(.success(let wodProgramStates)):
                state.wodProgramStates = IdentifiedArray(uniqueElements: wodProgramStates)
                return .none
            case .wodAddResponse(.failure(let error)):
                state.wodProgramStates = []
                return .none
            case .path:
                return .none
            case .didTapProgramView(let uuid):
                state.path.append(WodListFeature.State(id: uuid))
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            WodListFeature()
        }
    }

}

import SwiftUI
struct WodListProgramView: View {

    @Perception.Bindable var store: StoreOf<WodListProgramFeature>

    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    Button(action: {
                        store.send(.didTapAddProgramButton)
                    }, label: {
                        Text("새로운 프로그램 추가하기")
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(.yellow)
                            .foregroundStyle(.black)
                    })
                    .padding()
                    List {
                        ForEachStore(store.scope(state: \.wodProgramStates, action: \.wodProgramActions)) { programStore in
                            WodProgramView(store: programStore)
                                .onTapGesture {
                                    store.send(.didTapProgramView(programStore.workoutProgramModel.id))
                                }
                        }
                    }
                }
                .onAppear {
                    store.send(.onAppear)
                }
            } destination: { store in
                WodListView(store: store)
            }
        }
    }

}

#Preview {
    WodListProgramView(store: Store(initialState: WodListProgramFeature.State()) {
        WodListProgramFeature()
    })
}

