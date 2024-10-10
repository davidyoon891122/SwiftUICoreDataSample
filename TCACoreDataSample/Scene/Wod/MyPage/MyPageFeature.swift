//
//  MyPageFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MyPageFeature {

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
struct MyPageView: View {
    
    let store: StoreOf<MyPageFeature>

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
                
                RecentActivityListView(store: .init(initialState: RecentActivityListFeature.State()) {
                    RecentActivityListFeature()
                })
            }
        }
            
    }

}


