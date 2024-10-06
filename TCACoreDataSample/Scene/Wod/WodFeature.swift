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
            self.id = UUID()
            self.workOutInfoModel = .init(entity: workOutInfoEntity)
        }

        init(workOutInfoModel: WorkOutInfoModel) {
            self.id = UUID()
            self.workOutInfoModel = workOutInfoModel
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

struct WodView: View {

    let store: StoreOf<WodFeature>

    var body: some View {
        VStack {
            Text("WodView")
            List {
                ForEach(store.workOutInfoModel.workOutItems) { workOutItem in
                    Text(workOutItem.title)
                    ForEach(workOutItem.wodSet, id: \.self) { wodSet in
                        Text("\(wodSet.unitValue)")
                    }
                }
            }
        }
    }

}

#Preview {
    WodView(store: Store(initialState: WodFeature.State(workOutInfoModel: .preview)) {
        WodFeature()
    })
}

