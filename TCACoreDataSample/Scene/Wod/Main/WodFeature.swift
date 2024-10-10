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
        case didTapCompleteButton(UUID, UUID)
        case updateWodResponse(Result<UpdateWodResponse, Error>)
        case checkAllWodCompleted(DayWorkoutModel)
        case saveRecentWod
    }
    
    @Dependency(\.wodClient) var wodClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapCompleteButton(let wodId, let wodSetId):
                
                guard let wodIndex = state.workOutInfoModel.wods.firstIndex(where: { $0.id == wodId }),
                      let wodSetIndex = state.workOutInfoModel.wods[wodIndex].wodSet.firstIndex(where: { $0.id == wodSetId })
                else { return .none }
                
                state.workOutInfoModel.wods[wodIndex].wodSet[wodSetIndex].isCompleted.toggle()
                
                let updatedWod = WodFeature.State(parentId: state.id, id: wodSetId, workOutInfoModel: state.workOutInfoModel)
                
                return .run { [id = state.parentId, model = state.workOutInfoModel] send in
                    do {
                        let result = try wodClient.updateStates(id, updatedWod)
                        
                        await send(.checkAllWodCompleted(model))
                    } catch {
                        
                    }
                }
            case .updateWodResponse(.success(let response)):
                return .none
            case .updateWodResponse(.failure(let error)):
                return .none
            case .checkAllWodCompleted(let dayWodModel):
                if dayWodModel.wods.allSatisfy({ $0.wodSet.allSatisfy { $0.isCompleted }}) {
                    return .run { send in
                        await send(.saveRecentWod)
                    }
                }
                
                
                return .none
            case .saveRecentWod:
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
                Text("\(store.workOutInfoModel.type.title)")
                ForEach(store.workOutInfoModel.wods) { workOutItem in
                    Text(workOutItem.title)
                    ForEach(workOutItem.wodSet.sorted(by: {$0.unitValue < $1.unitValue}), id: \.self) { wodSet in
                        HStack {
                            Text("\(wodSet.unitValue)")
                            Spacer()
                            Button(action: {
                                store.send(.didTapCompleteButton(workOutItem.id, wodSet.id))
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

