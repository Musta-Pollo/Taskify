//
//  TasksStore.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

@MainActor
class TasksStore: ObservableObject {
    @Published var tasks: [Todo] = []
    @Published var projects: [Project] = []
    
    private static func fileURL() throws -> (tasksUrl: URL, projectsUrl: URL) {
        let defPath = try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        return (defPath.appendingPathComponent("tasks.data"), defPath.appendingPathComponent("projects.data"))
    }
    
    func load() async throws {
        let task = Task<([Todo], [Project]), Error> {
            let (tasksUrl, projectsUrl) = try Self.fileURL()
            guard let tasksData = try? Data(contentsOf: tasksUrl) else {
                return (Todo.sampleData, Project.sampleProjects)
            }
            guard let projectsData = try? Data(contentsOf: projectsUrl) else {
                return (Todo.sampleData,Project.sampleProjects)
            }
            let todos = try JSONDecoder().decode([Todo].self, from: tasksData)
            let projects = try JSONDecoder().decode([Project].self, from: projectsData)
            return (todos, projects)
        }
        let (todos, projects) = try await task.value
        self.tasks = todos
        self.projects = projects
    }
    
    func save(todos: [Todo], projects: [Project]) async throws {
        let task = Task {
            let todoData = try JSONEncoder().encode(todos)
            let projectData = try JSONEncoder().encode(projects)
            let (todoUrl, projectUrl) = try Self.fileURL()
            try todoData.write(to: todoUrl)
            try projectData.write(to: projectUrl)
        }
        _ = try await task.value
    }
}


extension TasksStore {
    static var testableTaskStore : TasksStore {
        var store =  TasksStore()
        store.tasks = Todo.sampleData
        store.projects = Project.sampleProjects
        return store
    }
}
