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

    var body: some View {
        VStack {
            Text("WodView")
        }
    }

}

