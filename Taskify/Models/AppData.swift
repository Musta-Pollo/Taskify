//
//  AppData.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import Foundation


struct AppData: Codable {
    var tasks: [Todo] = []
    var projects: [Project] = []
    var history: [History] = []
    
    static var sampleData: AppData {
        return AppData(tasks: Todo.sampleData, projects: Project.sampleProjects, history: History.sampleHistories)
    }
}
