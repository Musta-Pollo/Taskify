//
//  ProjectEditView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectEditView: View {
    @Binding var project: Project
    @EnvironmentObject var tasks: TasksStore
    var body: some View {
        Form {
            Section(header: Text("Default Info")) {
                TextField("Name", text: $project.name)
                ColorPicker(selectedColor: $project.idColor)
            }
        }
    }
    
}

struct ProjectEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditView(project: .constant(Project.sampleProjects[0])).environmentObject(TasksStore.testableTaskStore)
    }
}
