//
//  RecentCompletedWodModel.swift
//  TCACoreDataSample
//
//  Created by Davidyoon on 10/10/24.
//

import Foundation

struct RecentCompletedWodModel: Equatable {
    
    let id: UUID
    let title: String
    let date: String
    let duration: Int
    let weeklyWorkout: WeeklyWorkoutModel
    
    init(id: UUID, title: String, date: String, duration: Int, weeklyWorkout: WeeklyWorkoutModel) {
        self.id = id
        self.title = title
        self.date = date
        self.duration = duration
        self.weeklyWorkout = weeklyWorkout
    }
    
    init(entity: RecentCompletedWodEntity) {
        self.id = entity.id
        self.title = entity.title
        self.date = entity.date
        self.duration = Int(entity.duration)
        self.weeklyWorkout = WeeklyWorkoutModel(entity: entity.weeklyWorkout)
    }
    
}

extension RecentCompletedWodModel {
    
    static let preview: Self = .init(id: UUID(), title: "히어로 데이", date: "2024년 9월 31일 화요일", duration: 3800, weeklyWorkout: .preview)
    
}
