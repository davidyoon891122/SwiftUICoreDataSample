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
    }

    enum Action {
        case onAppear
        case wodProgramActions(id: WodProgramFeature.State.ID, action: WodProgramFeature.Action)
        case getAllProgramStates(Result<[WodProgramFeature.State], Error>)
        case didTapAddProgramButton
        case wodAddResponse(Result<[WodProgramFeature.State], Error>)
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
            }
        }
    }

}

import SwiftUI
struct WodListProgramView: View {

    let store: StoreOf<WodListProgramFeature>

    var body: some View {
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
                ForEachStore(store.scope(state: \.wodProgramStates, action: \.wodProgramActions)) { store in
                    WodProgramView(store: store)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }

}

#Preview {
    WodListProgramView(store: Store(initialState: WodListProgramFeature.State()) {
        WodListProgramFeature()
    })
}

