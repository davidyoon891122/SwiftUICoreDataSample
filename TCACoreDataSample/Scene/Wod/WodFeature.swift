//
//  WodFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WodFeature {

    @ObservableState
    struct State: Equatable, Identifiable {
        var id: UUID
        var workOutInfoModel: WorkOutInfoModel

        init(workOutInfoEntity: WorkOutInfoEntity) {
            self.id = workOutInfoEntity.id
            self.workOutInfoModel = .init(entity: workOutInfoEntity)
        }

        init(workOutInfoModel: WorkOutInfoModel) {
            self.id = UUID()
            self.workOutInfoModel = workOutInfoModel
        }

    }

    enum Action {
        case onAppear
        case didTapCompleteButton(UUID)
        case updateWodResponse(Result<UpdateWodResponse, Error>)
        case didTapTestButton
    }
    
    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("OnAppear")
                return .none
            case .didTapCompleteButton(let id):
                for itemIndex in state.workOutInfoModel.workOutItems.indices {
                    if let setIndex = state.workOutInfoModel.workOutItems[itemIndex].wodSet.firstIndex(where: { $0.id == id }) {
                        state.workOutInfoModel.workOutItems[itemIndex].wodSet[setIndex].isCompleted.toggle()
                    }
                }
                
                let updatedWod = WodFeature.State(workOutInfoModel: state.workOutInfoModel)
                print("didTapSetButton: \(id)")
                return .run { [id = state.id] send in
                    do {
                        let result = try wodClient.updateStates(id, updatedWod)
                    } catch {
                        
                    }
                }
            case .updateWodResponse(.success(let response)):
                
                return .none
                
            case .updateWodResponse(.failure(let error)):
                
                return .none
            case .didTapTestButton:
                print("DidTapTestButton")
                return .none
            }
        }
    }

}

import SwiftUI

struct WodView: View {

    let store: StoreOf<WodFeature>

    var body: some View {
        VStack(alignment: .leading) {
            Text("WodView")
            Button(action: {
                store.send(.didTapTestButton)
            }, label: {
                Text("ButtonText")
            })
            ForEach(store.workOutInfoModel.workOutItems) { workOutItem in
                Text(workOutItem.title)
                ForEach(workOutItem.wodSet, id: \.self) { wodSet in
                    HStack {
                        Text("\(wodSet.unitValue)")
                        Spacer()
                        Button(action: {
                            store.send(.didTapCompleteButton(wodSet.id))
                        }, label: {
                            wodSet.isCompleted ? Image(systemName: "circle") : Image(systemName: "xmark")
                        })
                    }
                    .frame(height: 56.0)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .padding(.horizontal)
    }

}

#Preview {
    WodView(store: Store(initialState: WodFeature.State(workOutInfoModel: .preview)) {
        WodFeature()
    })
}

