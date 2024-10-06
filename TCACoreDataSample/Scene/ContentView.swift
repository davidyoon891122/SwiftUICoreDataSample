//
//  ContentView.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import SwiftUI
import CoreData
import ComposableArchitecture

struct ContentView: View {

    var body: some View {
        WithPerceptionTracking {
//            UserListView(store: TCACoreDataSampleApp.store)
            WodListProgramView(store: TCACoreDataSampleApp.wodStore)
        }
    }

}

#Preview {
    ContentView()
}
