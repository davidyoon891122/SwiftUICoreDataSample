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
    var addWodProgram: () throws -> AddWodInfoEntityResponse
    var wodStates: (UUID) throws -> [WodFeature.State]
    var updateStates: (UUID, WodFeature.State) throws -> UpdateWodResponse
}

extension WodClient: DependencyKey {

    static let liveValue = Self(wodPrograms: {
        try WodCoreDataProvider.shared.getWodProgramStates()
    }, addWodProgram: {
        try WodCoreDataProvider.shared.addWodInfoEntity()
    }, wodStates: { id in
        try WodCoreDataProvider.shared.getWodStates(id: id)
    }, updateStates: { id, state in
        try WodCoreDataProvider.shared.updateWodState(id: id, wodState: state)
    })

}

extension DependencyValues {

    var wodClient: WodClient {
        get { self[WodClient.self] }
        set { self[WodClient.self] = newValue }
    }

}

struct AddWodInfoEntityResponse: Equatable {
    let programStates: [WodProgramFeature.State]
}

struct UpdateWodResponse: Equatable {
    let updatedWod: WodFeature.State?
    let allWods: [WodFeature.State]
}
