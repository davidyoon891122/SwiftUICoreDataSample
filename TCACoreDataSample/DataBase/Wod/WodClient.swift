//
//  WodClient.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/6/24.
//

import Foundation
import ComposableArchitecture

struct WodClient {
    var wodPrograms: () throws -> [WodProgramFeature.State]
}

extension WodClient: DependencyKey {

    static let liveValue = Self(wodPrograms: {
        try WodCoreDataProvider.shared.getWodProgramStates()
    })

}

extension DependencyValues {

    var wodClient: WodClient {
        get { self[WodClient.self] }
        set { self[WodClient.self] = newValue }
    }

}
