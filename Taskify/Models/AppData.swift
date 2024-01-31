//
//  AppData.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import SwiftUI


struct AppData: Codable {
    var tasks: [Todo] = []
    var projects: [Project] = []
    var history: [History] = []
    
    static var sampleData: AppData {
        return AppData(tasks: Todo.sampleData, projects: Project.sampleProjects, history: History.sampleHistories)
    }
}


extension AppData {
    func projectById(projectId: UUID?) -> Project? {
        return projects.first(where: { $0.id == projectId })
    }
    
    func projectByIdNonNull(projectId: UUID?) -> Project {
        return projectById(projectId: projectId) ?? .sampleProjects[0]
    }
    
    
    func projectByIdColor(projectId: UUID?) -> Color?{
        return projectById(projectId: projectId)?.color.color
    }
    
    func taskHistory(taskId: UUID) -> [History] {
        return history.filter { $0.taskId == taskId }.sorted
    }

    func projectHistory(projectId: UUID) -> [History] {
        return history.filter { $0.projectId == projectId }.sorted
    }
    
    func historyForId(historyId: UUID) -> History {
        return history.first(where: {$0.id == historyId})!
    }
    
}
