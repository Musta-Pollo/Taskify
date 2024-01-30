//
//  Project.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation
import SwiftUI

struct RGB: Codable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
}


struct Project: Identifiable, Codable {
    let id: UUID
    var name: String
    var color: RGB
    
    
    init(id: UUID = UUID(), name: String, color: RGB) {
        self.id = id
        self.name = name
        self.color = color
    }
}


extension Project {
    static var emptyProject : Project {
        return Project(name: "", color: RGB(red: 1, green: 1, blue: 1, alpha: 1))
    }
    var colorColor : Color {
        return Color(red: color.red, green: color.green, blue: color.blue)
    }
    static let sampleProjects: [Project] = [
        Project(name: "Work", color: RGB(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)),
        Project(name: "Eating", color: RGB(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)),
        Project(name: "Cleaning", color: RGB(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)),
        Project(name: "Reading", color: RGB(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)),
        Project(name: "Training", color: RGB(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)),
        Project(name: "Walk", color: RGB(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)),
        Project(name: "Shool", color: RGB(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        Project(name: "Personal", color: RGB(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)),
        Project(name: "Relationships", color: RGB(red: 0.5, green: 1.0, blue: 0.0, alpha: 1.0)),
        Project(name: "Personal Development", color: RGB(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0))
    ]
   
}
