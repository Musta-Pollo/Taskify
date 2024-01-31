//
//  Task.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation
import SwiftUI

struct Todo: Identifiable, Codable {
    let id: UUID
    var name: String
    var isCompleted: Bool
    var priority: Priority
    var dateTime: Date?
    var note: String
    var projectId: UUID?
    
    
    init(id: UUID = UUID(), name: String, priority: Priority, dateTime: Date? = nil, projectId: UUID? = nil, isCompleted: Bool = false, note: String = "") {
        self.id = id
        self.name = name
        self.priority = priority
        self.dateTime = dateTime
        self.projectId = projectId
        self.isCompleted = isCompleted
        self.note = note
    }
    
    var nonNullDateTime : Date {
        set {
            self.dateTime = newValue
        }
        
        get {
            if(dateTime == nil)  {return Date.now}
            return dateTime.unsafelyUnwrapped
        }
    }

}


extension Todo {
    static var emptyTodo : Todo {
        return Todo(name: "", priority: Priority.none)
    }
    static let sampleData: [Todo] = [
            Todo(name: "Grocery Shopping", priority: .high, dateTime: Date(timeIntervalSinceNow: 3600)), // 1 hour from now
            Todo(name: "Finish Project Report", priority: .medium, dateTime: Date(timeIntervalSinceNow: 86400)), // 1 day from now
            Todo(name: "Book Doctor's Appointment", priority: .low, dateTime: Date(timeIntervalSinceNow: 172800)), // 2 days from now
            Todo(name: "Plan Weekend Trip", priority: .none, dateTime: Date(timeIntervalSinceNow: 604800)), // 1 week from now
            Todo(name: "Attend Team Meeting", priority: .high, dateTime: Date(timeIntervalSinceNow: 10800)), // 3 hours from now
            Todo(name: "Yoga Class", priority: .medium, dateTime: Date(timeIntervalSinceNow: 259200)), // 3 days from now
            Todo(name: "Car Maintenance", priority: .low, dateTime: Date(timeIntervalSinceNow: 432000)), // 5 days from now
            Todo(name: "Prepare Birthday Gift", priority: .medium, dateTime: Date(timeIntervalSinceNow: 691200)), // 8 days from now
            Todo(name: "Dental Checkup", priority: .high, dateTime: Date(timeIntervalSinceNow: 900000)), // 10.4 days from now
            Todo(name: "Call Parents", priority: .none, dateTime: Date(timeIntervalSinceNow: 1209600)) // 14 days from now
        ]
    
}


extension Binding<[Todo]> {
    var sortedTodos: Binding<[Todo]> {
            Binding<[Todo]>(
                get: {
                        
                        var sortedByPriority = wrappedValue.sorted { task1, task2 in
                            return task1.priority.value < task2.priority.value
                        }
                        var sortedByDeadline =  sortedByPriority.sorted { task1, task2 in
                            return task1.nonNullDateTime < task2.nonNullDateTime
                        }
                    return sortedByDeadline.sorted { task1, task2 in
                        return (task1.isCompleted ? 1 : 0) < (task2.isCompleted ? 1 : 0)
                    }
                    
//                     wrappedValue.sorted { (task1: Todo, task2: Todo) in
//                                if task1.priority.value == task2.priority.value {
//                                    // If priorities are equal, sort by deadline
//                                    return task1.dateTime < task2.dateTime
//                                } else {
//                                    // Otherwise, sort by priority
//                                    return task1.priority.value < task2.priority.value
//                                }
//                            }
                },
                set: { newValue in
                    wrappedValue = newValue
                }
            )
        }
}
