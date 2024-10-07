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
        self.removeWodInfoEntity()

        let wodInfoEntity = WodInfoEntity.instance(with: self.context, model: WodInfoModel.mock)

        let wodProgramStates = wodInfoEntity.weeklyWorkoutProgram.compactMap { programEntity -> WodProgramFeature.State? in

            guard let programEntity = programEntity as? WeeklyWorkoutProgramEntity else { return nil }

            return WodProgramFeature.State(workoutProgramEntity: programEntity)
        }

        try context.save()

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

    func removeWodInfoEntity() {
        guard let entities = try? self.fetchAllWodInfo() else { return }

        entities.forEach {
            let item = context.object(with: $0.objectID)
            context.delete(item)
        }

        try? context.save()

        print("Delete Completed")
    }
    
    func updateWodState(id: UUID, wodState: WodFeature.State) throws -> UpdateWodResponse {
        guard let wodInfoEntity = try self.fetchWodInfo() else { return .init(updatedWod: nil, allWods: []) }
        
        let targetWodProgram = wodInfoEntity.weeklyWorkoutProgram
            .compactMap {
                $0 as? WeeklyWorkoutProgramEntity
            }
            .filter { $0.id == id }
            .first

        guard let targetWodProgram = targetWodProgram else { return .init(updatedWod: nil, allWods: []) }
        
        let result = targetWodProgram.workOutInfos.compactMap { $0 as? WorkOutInfoEntity }
//        let workoutItems = result.compactMap { $0.workOutItem as? WorkOutItemEntity }
        
        print(type(of: result.first?.workOutItem))
        
        return .init(updatedWod: nil, allWods: [])
    }

}

private extension WodCoreDataProvider {

    func fetchWodInfo() throws -> WodInfoEntity? {
        let wodInfo = try context.fetch(WodCoreData.shared.fetchRequest())
        print(wodInfo.count)
        let firstWod = wodInfo.first

        return firstWod
    }

    func fetchAllWodInfo() throws -> [WodInfoEntity] {
        let wodInfoEntities = try context.fetch(WodCoreData.shared.fetchRequest())
        return wodInfoEntities
    }

}
