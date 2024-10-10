//
//  WodProgramFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/6/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct WodProgramFeature {

    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        var workoutProgramModel: WeeklyWorkoutModel
        var isCompleted: Bool {
            get {
                workoutProgramModel.isCompleteAllItem
            }
        }

        init(workoutProgramModel: WeeklyWorkoutModel) {
            self.id = workoutProgramModel.id
            self.workoutProgramModel = workoutProgramModel
        }

        init(workoutProgramEntity: WeeklyWorkoutEntity) {
            self.id = workoutProgramEntity.id
            self.workoutProgramModel = .init(entity: workoutProgramEntity)
        }

    }

    enum Action {
        case didTapComplete
        case didTapWod
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapComplete:
                return .none
            case .didTapWod:
                return .none
            }
        }
    }

}

import SwiftUI
struct WodProgramView: View {

    let store: StoreOf<WodProgramFeature>

    var body: some View {
        WithPerceptionTracking {
            HStack {
                Text(store.workoutProgramModel.type.rawValue)
                VStack(alignment: .leading) {
                    Text(store.workoutProgramModel.title)
                    Text(store.workoutProgramModel.subTitle)
                }
                Spacer()
                Button(action: {
                    store.send(.didTapComplete)
                }, label: {
                    Image(systemName: store.isCompleted ? "circle" : "xmark")
                })
            }
            .contentShape(Rectangle())
            .onTapGesture {
                store.send(.didTapWod)
            }
        }
    }

}

#Preview {
    WodProgramView(store: Store(initialState: WodProgramFeature.State(workoutProgramModel: .preview)) {
        WodProgramFeature()
    })
}

