//
//  WodCoreDataProvider.swift
//  TCACoreDataSample
//
//  Created by Jiwon Yoon on 10/5/24.
//

import Foundation
import ComposableArchitecture

final class WodCoreDataProvider {

    static let shared = WodCoreDataProvider()

    private let context = WodCoreData.shared.context

    func getWodProgramStates() throws -> [WodProgramFeature.State] {
        guard let wodInfoEntity = try self.fetchWodInfo() else { return [] }

        let wodProramStates = wodInfoEntity.weeklyWorkoutProgram.map {
            WodProgramFeature.State(workoutProgramEntity: $0 as! WeeklyWorkoutProgramEntity)
        }

        return wodProramStates
    }


}

private extension WodCoreDataProvider {

    func fetchWodInfo() throws -> WodInfoEntity? {
        let wodInfo = try context.fetch(WodCoreData.shared.fetchRequest())

        let firstWod = wodInfo.first

        return firstWod
    }

}
