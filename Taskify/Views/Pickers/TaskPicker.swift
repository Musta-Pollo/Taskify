//
//  TaskPicker.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

struct TaskPicker: View {
    @Binding var selectedTaskId: UUID?
    @Binding var appData: AppData
    var selectedProjectId: UUID?
    var canPickNone: Bool
    
    init(selectedTaskId: Binding<UUID?>, appData: Binding<AppData>, selectedProjectId: UUID? = nil,  canPickNone: Bool = true) {
        self._selectedTaskId = selectedTaskId
        self._appData = appData
        self.canPickNone = canPickNone
        self.selectedProjectId = selectedProjectId
    }
    
    var body: some View {
        Picker("Task", selection: $selectedTaskId) {
            let tasks = canPickNone ? appData.tasks.optionalTasksForProjectId(projectId: selectedProjectId) : appData.tasks.optionalTasksWithoutNone(projectId: selectedProjectId)
            ForEach(tasks) { task in
                
                TaskView(task: task.task, appData: appData)
                    .tag(task.id as UUID?)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct TaskPicker_Previews: PreviewProvider {
    static var previews: some View {
        TaskPicker(selectedTaskId: .constant(nil), appData: .constant(TasksStore.testableTaskStore.appData))
    }
}
