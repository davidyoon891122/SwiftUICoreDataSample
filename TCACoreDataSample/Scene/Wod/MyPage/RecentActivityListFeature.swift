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
        var recentActivityState: IdentifiedArrayOf<RecentActivityFeature.State> = []
    }

    enum Action {
        case onAppear
        case recentActivityActions(IdentifiedActionOf<RecentActivityFeature>)
    }

    
    @Dependency(\.wodClient) var wodClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .recentActivityActions:
                return .none
            }
        }
        .forEach(\.recentActivityState, action: \.recentActivityActions) {
            RecentActivityFeature()
        }
    }

}

import SwiftUI
struct RecentActivityListView: View {
    
    let store: StoreOf<RecentActivityListFeature>

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                    VStack(alignment: .leading) {
                        Text("Username")
                        Text("초급")
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                
                Color
                    .blue
                    .frame(height: 400.0)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("최근 활동")
                    ForEach(store.scope(state: \.recentActivityState, action: \.recentActivityActions)) { store in
                        RecentActivityView(store: store)
                    }
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
    
}

#Preview {
    RecentActivityListView(store: Store(initialState: RecentActivityListFeature.State()) {
        RecentActivityListFeature()
    })
}
