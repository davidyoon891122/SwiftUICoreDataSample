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
        case wodProgramActions(IdentifiedActionOf<WodProgramFeature>)
        case getAllProgramStates(Result<[WodProgramFeature.State], Error>)
        case didTapAddProgramButton
        case wodAddResponse(Result<[WodProgramFeature.State], Error>)
        case path(StackAction<WodListFeature.State, WodListFeature.Action>)
        case remove
        case removeWodProgram(Result<[WodProgramFeature.State], Error>)
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

            case .wodProgramActions(.element(id: let id, action: .didTapComplete)):
                print("id: \(id) send tapped action to the parent")
                return .none
            case .wodProgramActions(.element(id: let id, action: .didTapWod)):
                guard let workoutProgramModel = state.wodProgramStates[id: id]?.workoutProgramModel else { return .none }
                
                print(workoutProgramModel)
                
                state.path.append(WodListFeature.State(id: id, title: workoutProgramModel.title))
                return .none
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
                        print(error.localizedDescription)
                        
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
            case .remove:
                return .run { send in
                    do {
                        let response = try wodClient.removeWodProgram()
                        await send(.removeWodProgram(.success(response.allWods)))
                    } catch {
                        await send(.removeWodProgram(.failure(error)))
                    }
                }
            case .removeWodProgram(.success(let result)):
                state.wodProgramStates = IdentifiedArray(uniqueElements: result)
                return .none
            case .removeWodProgram(.failure(let error)):
                state.wodProgramStates = []
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
                    Button(action: {
                        store.send(.remove)
                    }, label: {
                        Text("Remove")
                    })
                    ScrollView {
                        LazyVStack {
                            ForEach(store.scope(state: \.wodProgramStates, action: \.wodProgramActions)) { programStore in
                                WodProgramView(store: programStore)
                                    .padding()
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

