//
//  ProjectPicker.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectPicker: View {
    @Binding var selectedProjectId: UUID?
    @EnvironmentObject var tasks: TasksStore
    
    
    var body: some View {
        Picker("Project", selection: $selectedProjectId) {
            ForEach(tasks.projects) { project in
                ProjectView(project: project)
                    .tag(project.id as UUID?)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPicker(selectedProjectId: .constant(nil)).environmentObject(TasksStore())
    }
}