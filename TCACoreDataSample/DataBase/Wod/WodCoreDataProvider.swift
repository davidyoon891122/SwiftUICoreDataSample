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
            WodProgramFeature.State(workoutProgramEntity: $0)
        }

        return wodProramStates
    }

    func addWodInfoEntity() throws -> AddWodInfoEntityResponse {
        self.removeWodInfoEntity()

        let wodInfoEntity = WodInfoEntity.instance(with: self.context, model: WodInfoModel.mock)

        let wodProgramStates = wodInfoEntity.weeklyWorkoutProgram.compactMap {
            return WodProgramFeature.State(workoutProgramEntity: $0)
        }

        try context.save()

        return .init(programStates: wodProgramStates)
    }

    func getWodStates(id: UUID) throws -> [WodFeature.State] {
        guard let wodInfoEntity = try self.fetchWodInfo() else { return [] }

        let targetWodProgram = wodInfoEntity.weeklyWorkoutProgram
            .filter { $0.id == id }
            .first

        guard let targetWodProgram = targetWodProgram else { return [] }

        return targetWodProgram.workOutInfos
        .map {
            WodFeature.State(parentId: id, workOutInfoEntity: $0)
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
            .filter { $0.id == id }
            .first

        guard let targetWodProgram = targetWodProgram else { return .init(updatedWod: nil, allWods: []) }
        
        guard let objectID = targetWodProgram.workOutInfos.filter({ $0.id == wodState.workOutInfoModel.id }).first?.objectID,
        let workoutInfoEntity = context.object(with: objectID) as? WorkOutInfoEntity else { return .init(updatedWod: nil, allWods: [])}
        
        workoutInfoEntity.workOutItem = Set(wodState.workOutInfoModel.workOutItems.map {
            WorkOutItemEntity.convertModelToEntity(with: context, model: $0)
        })
        
        do {
            try context.save()
        } catch {
            print("update error: \(error.localizedDescription)")
        }
        
        
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
