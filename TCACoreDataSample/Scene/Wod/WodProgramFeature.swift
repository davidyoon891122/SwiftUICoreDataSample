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

        init(workoutProgramModel: WeeklyWorkoutModel) {
            self.id = UUID()
            self.workoutProgramModel = workoutProgramModel
        }

        init(workoutProgramEntity: WeeklyWorkoutEntity) {
            self.id = UUID()
            self.workoutProgramModel = .init(entity: workoutProgramEntity)
        }

    }

    enum Action {

    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {

            }
        }
    }

}

import SwiftUI
struct WodProgramView: View {

    let store: StoreOf<WodProgramFeature>

    var body: some View {
        HStack {
            Text(store.workoutProgramModel.type.rawValue)
            VStack(alignment: .leading) {
                Text(store.workoutProgramModel.title)
                Text(store.workoutProgramModel.subTitle)
            }
        }
    }

}

#Preview {
    WodProgramView(store: Store(initialState: WodProgramFeature.State(workoutProgramModel: .preview)) {
        WodProgramFeature()
    })
}

