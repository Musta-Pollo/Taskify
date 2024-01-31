//
//  History.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import Foundation

struct History: Identifiable, Codable, Hashable{
    let id: UUID
    let start: Date
    let end: Date
    let projectId: UUID
    let taskId: UUID?

   init(start: Date, end: Date, projectId: UUID, taskId: UUID? = nil) {
       self.id = UUID() // Generate a unique ID for each history
       self.start = start
       self.end = end
       self.projectId = projectId
       self.taskId = taskId
   }

    // Helper function to calculate the duration of the history
    func duration() -> TimeInterval {
        return end.timeIntervalSince(start)
    }

    // Helper function to format the duration into a readable string
    func formattedDuration() -> String {
        let duration = self.duration()
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        let seconds = Int(duration) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }

    // Example of a helper function to check if the history overlaps with another history
    func overlaps(with other: History) -> Bool {
        return start < other.end && end > other.start
    }

    // Add other helper functions as needed
}

extension History {
    static let sampleHistories: [History] = [
        History(start: Date(timeIntervalSinceNow: -3600 * 5),  // 5 hours ago
                end: Date(timeIntervalSinceNow: -3600 * 4),    // 4 hours ago
                projectId: Project.sampleProjects[0].id),
        History(start: Date(timeIntervalSinceNow: -3600 * 3),  // 3 hours ago
                end: Date(timeIntervalSinceNow: -3600 * 2),    // 2 hours ago
                projectId: Project.sampleProjects[1].id),
        History(start: Date(timeIntervalSinceNow: -3600),      // 1 hour ago
                end: Date(),
                projectId: Project.sampleProjects[2].id)
    ]
    
}

extension [History] {
    var sorted: [History]{
        sorted { h1, h2 in
            return h1.start < h2.start
        }
    }
}

