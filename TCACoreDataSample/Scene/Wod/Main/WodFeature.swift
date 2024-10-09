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
        var parentId: UUID
        var id: UUID
        var workOutInfoModel: DayWorkoutModel

        init(parentId: UUID, workOutInfoEntity: DayWorkoutEntity) {
            self.parentId = parentId
            self.id = workOutInfoEntity.id
            self.workOutInfoModel = .init(entity: workOutInfoEntity)
        }

        init(parentId: UUID, id: UUID, workOutInfoModel: DayWorkoutModel) {
            self.parentId = parentId
            self.id = UUID()
            self.workOutInfoModel = workOutInfoModel
        }

    }

    enum Action {
        case didTapCompleteButton(UUID)
        case updateWodResponse(Result<UpdateWodResponse, Error>)
    }
    
    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCompleteButton(let id):
                for itemIndex in state.workOutInfoModel.wods.indices {
                    if let setIndex = state.workOutInfoModel.wods[itemIndex].wodSet.firstIndex(where: { $0.id == id }) {
                        state.workOutInfoModel.wods[itemIndex].wodSet[setIndex].isCompleted.toggle()
                    }
                }
                
                let updatedWod = WodFeature.State(parentId: state.id, id: id, workOutInfoModel: state.workOutInfoModel)
                print("didTapSetButton: \(id)")
                return .run { [id = state.parentId] send in
                    do {
                        let result = try wodClient.updateStates(id, updatedWod)
                    } catch {
                        
                    }
                }
            case .updateWodResponse(.success(let response)):
                return .none
            case .updateWodResponse(.failure(let error)):
                return .none
            }
        }
    }

}

import SwiftUI

struct WodView: View {

    let store: StoreOf<WodFeature>

    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                Text("WodView")
                ForEach(store.workOutInfoModel.wods) { workOutItem in
                    Text(workOutItem.title)
                    ForEach(workOutItem.wodSet.sorted(by: {$0.unitValue < $1.unitValue}), id: \.self) { wodSet in
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
            .padding(.horizontal)
        }
    }

}

#Preview {
    WodView(store: Store(initialState: WodFeature.State(parentId: UUID(), id: UUID(), workOutInfoModel: .preview)) {
        WodFeature()
    })
}

