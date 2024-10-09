//
//  RecentActivityListFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RecentActivityListFeature {

    @ObservableState
    struct State {

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
struct RecentActivityListView: View {

    var body: some View {
        VStack {
            Text("RecentActivityListView")
        }
    }
    
}
