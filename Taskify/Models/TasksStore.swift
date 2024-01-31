//
//  TasksStore.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

@MainActor
class TasksStore: ObservableObject {
    @Published var appData: AppData = AppData()

    
    private static func fileURL() throws -> URL {
        let defPath = try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        return defPath.appendingPathComponent("appData.data")
    }
    
    func load() async throws {
        let task = Task<AppData, Error> {
            let url = try Self.fileURL()
            guard let appDataData = try? Data(contentsOf: url) else {
                return AppData.sampleData;
            }
           
            let appData = try JSONDecoder().decode(AppData.self, from: appDataData)
            return appData;
        }
        let appData = try await task.value
        self.appData = appData
    }
    
    func save() async throws {
        let task = Task {
            let appData = try JSONEncoder().encode(appData)
            let url = try Self.fileURL()
            try appData.write(to: url)
        }
        _ = try await task.value
    }
}


extension TasksStore {
    static var testableTaskStore : TasksStore {
        let store =  TasksStore()
        store.appData = AppData.sampleData
        return store
    }
    
    func projectById(projectId: UUID?) -> Project? {
        return appData.projects.first(where: { $0.id == projectId })
    }
    
    func projectByIdNonNull(projectId: UUID?) -> Project {
        return projectById(projectId: projectId) ?? .sampleProjects[0]
    }
    
    
    func projectByIdColor(projectId: UUID?) -> Color?{
        return projectById(projectId: projectId)?.color.color
    }
    
    var projects: [Project] {
        set {
            self.appData.projects = newValue
        }
        
        get {
            return self.appData.projects
        }
    }
    var tasks: [Todo] {
        set {
            self.appData.tasks = newValue
        }
        
        get {
            return self.appData.tasks
        }
    }
    var history: [History] {
        set {
            self.appData.history = newValue
        }
        
        get {
            return self.appData.history
        }
    };
    
    
    
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
