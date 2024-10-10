//
//  TCACoreDataSampleApp.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/3/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCACoreDataSampleApp: App {

    static let store = Store(initialState: UserListFeature.State()) {
        UserListFeature()
    }

    static let wodStore = Store(initialState: WodListProgramFeature.State()) {
        WodListProgramFeature()
    }
    
    static let mypPageStore = Store(initialState: MyPageFeature.State()) {
        MyPageFeature()
    }

    var body: some Scene {
        WindowGroup {
            WithPerceptionTracking {
                ContentView()
            }
        }
    }
}
