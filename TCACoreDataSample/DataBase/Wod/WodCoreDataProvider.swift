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

        let wodProramStates = wodInfoEntity.weeklyWorkouts.map {
            WodProgramFeature.State(workoutProgramEntity: $0 as! WeeklyWorkoutEntity)
        }

        return wodProramStates
    }

    func addWodInfoEntity() throws -> AddWodInfoEntityResponse {
        context.reset()
        let wodInfoEntity = ProgramsEntity.instance(with: self.context, model: ProgramsModel.mock)

        let wodProgramStates = wodInfoEntity.weeklyWorkouts.compactMap {
            return WodProgramFeature.State(workoutProgramEntity: $0 as! WeeklyWorkoutEntity)
        }
        
        try context.save()

        return .init(programStates: wodProgramStates)
    }

    func getWodStates(id: UUID) throws -> [WodFeature.State] {
        guard let wodInfoEntity = try self.fetchWodInfo() else { return [] }

        let targetWodProgram = wodInfoEntity.weeklyWorkouts
            .compactMap { $0 as? WeeklyWorkoutEntity }
            .filter { $0.id == id }
            .first

        guard let targetWodProgram = targetWodProgram else { return [] }

        return targetWodProgram.dayWorkouts
        .map {
            WodFeature.State(parentId: id, workOutInfoEntity: $0 as! DayWorkoutEntity)
        }
    }

    func removeWodInfoEntity() throws ->  RemoveWodResponse {
        context.reset()
        guard let entities = try? self.fetchAllWodInfo() else { return .init(allWods: []) }

        entities.forEach {
            let item = context.object(with: $0.objectID)
            context.delete(item)
        }
        
        try context.save()
        print("Delete Completed")
        
        return .init(allWods: [])
    }
    
    func updateWodState(id: UUID, wodState: WodFeature.State) throws -> UpdateWodResponse {
        guard let wodInfoEntity = try self.fetchWodInfo() else { return .init(updatedWod: nil, allWods: []) }
        
        let targetWodProgram = wodInfoEntity.weeklyWorkouts
            .compactMap { $0 as? WeeklyWorkoutEntity }
            .filter { $0.id == id }
            .first

        guard let targetWodProgram = targetWodProgram else { return .init(updatedWod: nil, allWods: []) }
        
        guard let objectID = targetWodProgram.dayWorkouts.compactMap({ $0 as? DayWorkoutEntity }).filter({ $0.id == wodState.workOutInfoModel.id }).first?.objectID,
        let workoutInfoEntity = context.object(with: objectID) as? DayWorkoutEntity else { return .init(updatedWod: nil, allWods: [])}
        
        workoutInfoEntity.type = "ModifiedType"
        workoutInfoEntity.wods = NSOrderedSet(array: wodState.workOutInfoModel.wods.map {
            WodEntity.convertModelToEntity(with: context, model: $0)
        })
        
        do {
            try context.save()
        } catch {
            print("update error: \(error.localizedDescription)")
        }
        
        print("Updated Objects: \(context.updatedObjects)")
        
        
        return .init(updatedWod: nil, allWods: [])
    }

}

private extension WodCoreDataProvider {

    func fetchWodInfo() throws -> ProgramsEntity? {
        let wodInfo = try context.fetch(WodCoreData.shared.fetchRequest())
        print(wodInfo.count)
        let firstWod = wodInfo.first

        return firstWod
    }

    func fetchAllWodInfo() throws -> [ProgramsEntity] {
        let wodInfoEntities = try context.fetch(WodCoreData.shared.fetchRequest())
        return wodInfoEntities
    }

}
