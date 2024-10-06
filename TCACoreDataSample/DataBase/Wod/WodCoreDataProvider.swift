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

    func addWodInfoEntity() throws -> AddWodInfoEntityResponse {
        let wodInfoEntity = WodInfoEntity.instance(with: self.context, model: WodInfoModel.mock)

        let wodProgramStates = wodInfoEntity.weeklyWorkoutProgram.compactMap { programEntity -> WodProgramFeature.State? in

            guard let programEntity = programEntity as? WeeklyWorkoutProgramEntity else { return nil }

            return WodProgramFeature.State(workoutProgramEntity: programEntity)
        }

        return .init(programStates: wodProgramStates)
    }

    func getWodStates(id: UUID) throws -> [WodFeature.State] {
        guard let wodInfoEntity = try self.fetchWodInfo() else { return [] }

        let targetWodProgram = wodInfoEntity.weeklyWorkoutProgram
            .compactMap {
                $0 as? WeeklyWorkoutProgramEntity
            }
            .filter { $0.id == id }
            .first

        guard let targetWodProgram = targetWodProgram else { return [] }

        return targetWodProgram.workOutInfos.compactMap {
            $0 as? WorkOutInfoEntity
        }
        .map {
            WodFeature.State(workOutInfoEntity: $0)
        }

    }


}

private extension WodCoreDataProvider {

    func fetchWodInfo() throws -> WodInfoEntity? {
        let wodInfo = try context.fetch(WodCoreData.shared.fetchRequest())

        let firstWod = wodInfo.first

        return firstWod
    }

}
