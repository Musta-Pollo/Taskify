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
        set {
                let components = newValue.cgColor?.components
                let red = components?.indices.contains(0) ?? false ? CGFloat(components![0]) : 0
                let green = components?.indices.contains(1) ?? false ? CGFloat(components![1]) : 0
                let blue = components?.indices.contains(2) ?? false ? CGFloat(components![2]) : 0
                let alpha = components?.indices.contains(3) ?? false ? CGFloat(components![3]) : 1

                self.color = RGB(red: red, green: green, blue: blue, alpha: alpha)
            }
        get{
            return Color(red: color.red, green: color.green, blue: color.blue)
        }
        
    }
    
    var colorName: String {
        get {
            for (color, name) in Color.standardColors {
                if color == colorColor {
                    return name
                }
            }
            return "Unknown"
        }
        set {
            if let newColor = Color.nameToColor[newValue] {
                colorColor = newColor
            }
        }
    }
    
    var idColor : IdColor {
        set {
            self.colorColor = newValue.color
        }
        get {
            IdColor(color: self.colorColor)
        }
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
    
    var optionalProject: OptionalProject{
        return OptionalProject(project: self)
    }
    
    
   
}

extension [Project]{
    var optionalProjects : [OptionalProject]{
        return  [OptionalProject(project: nil)] + self.map({$0.optionalProject})
    }
}


struct OptionalProject {
    let project: Project?
}

extension OptionalProject: Identifiable {
    var id: UUID { project?.id ?? UUID() }
}
