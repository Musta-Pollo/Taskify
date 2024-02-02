//
//  Project.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation
import SwiftUI


struct Project: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var color: ColorType
    
    
    init(id: UUID = UUID(), name: String, color: ColorType) {
        self.id = id
        self.name = name
        self.color = color
    }
    
}


extension Project {
    static var emptyProject : Project {
        return Project(name: "", color: ColorType.red)
    }
    
    static let sampleProjects: [Project] = [
        Project(id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174003")!, name: "Inbox", color: ColorType.gray),
        Project(id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174000")!, name: "Work", color: ColorType.red),
        Project(id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174001")!, name: "Eating", color: ColorType.blue),
        Project(id: UUID(uuidString: "123e4567-e89b-12d3-a456-426614174002")!, name: "Cleaning", color: ColorType.orange)
//        Project(name: "Reading", color: RGB(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)),
//        Project(name: "Training", color: RGB(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)),
//        Project(name: "Walk", color: RGB(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)),
//        Project(name: "Shool", color: RGB(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)),
//        Project(name: "Personal", color: RGB(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)),
//        Project(name: "Relationships", color: RGB(red: 0.5, green: 1.0, blue: 0.0, alpha: 1.0)),
//        Project(name: "Personal Development", color: RGB(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0))
    ]
    
    var optionalProject: OptionalProject{
        return OptionalProject(project: self)
    }
    
    
   
}

extension [Project]{
    var optionalProjects : [OptionalProject]{
        return  [OptionalProject(project: nil)] + self.map({$0.optionalProject})
    }
    var optionalProjectsWithoutNone : [OptionalProject]{
        return  self.map({$0.optionalProject})
    }
}



struct OptionalProject {
    let project: Project?
}

extension OptionalProject: Identifiable {
    var id: UUID { project?.id ?? UUID() }
    
    var projectId: UUID? {
        return project?.id
    }
}
