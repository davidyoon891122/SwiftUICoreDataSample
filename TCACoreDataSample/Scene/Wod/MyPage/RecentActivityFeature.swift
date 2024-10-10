//
//  RecentActivityFeature.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RecentActivityFeature {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        let recentCompletedWodModel: RecentCompletedWodModel
        
        init(id: UUID, recentCompletedWodModel: RecentCompletedWodModel) {
            self.id = recentCompletedWodModel.id
            self.recentCompletedWodModel = recentCompletedWodModel
        }
        
    }
    
    enum Action {
        
    }
    
    var some: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
    
}

import SwiftUI
struct RecentActivityView: View {
    
    let store: StoreOf<RecentActivityFeature>
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                VStack(alignment: .leading) {
                    HStack {
                        Text(store.recentCompletedWodModel.title)
                        Spacer()
                        Text("\(store.recentCompletedWodModel.duration)")
                    }
                    Text(store.recentCompletedWodModel.date)
                        .foregroundStyle(.gray)
                }
            }
            .padding()
            .background(.gray.opacity(0.15))
            .clipShape(.rect(cornerRadius: 6))
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    RecentActivityView(store: Store(initialState: RecentActivityFeature.State(id: UUID(), recentCompletedWodModel: .preview)) {
        RecentActivityFeature()
    })
}
