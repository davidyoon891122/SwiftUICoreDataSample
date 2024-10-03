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

    var body: some Scene {
        WindowGroup {
            WithPerceptionTracking {
                ContentView()
            }
        }
    }
}
