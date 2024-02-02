//
//  ProjectPicker.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectPicker: View {
    @Binding var selectedProjectId: UUID?
    @Binding var appData: AppData
    var canPickNone : Bool
    
    init(selectedProjectId: Binding<UUID?>, appData: Binding<AppData>, canPickNone: Bool = true) {
        self._selectedProjectId = selectedProjectId
        self._appData = appData
        self.canPickNone = canPickNone
    }
    
    var body: some View {
        Picker("Project", selection: $selectedProjectId) {
            ForEach(canPickNone ? appData.projects.optionalProjects : appData.projects.optionalProjectsWithoutNone) { project in
                
                ProjectView(project: project.project)
                    .tag(project.projectId as UUID?)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPicker(selectedProjectId: .constant(nil), appData: .constant(TasksStore.testableTaskStore.appData))
    }
}
