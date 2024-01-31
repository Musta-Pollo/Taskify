//
//  NewProjectSheet.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import SwiftUI

struct NewProjectSheet: View {
    @State private var newProject = Project.emptyProject
    @Binding var appData: AppData
    @Binding var isPresentingNewProjectView: Bool
    
    var body: some View {
        NavigationStack {
            ProjectEditView(project: $newProject, appData: $appData)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewProjectView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            appData.projects.append(newProject)
                            isPresentingNewProjectView = false
                        }
                    }
                }
        }
    }
}

struct NewProjectSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectSheet( appData: .constant(TasksStore.testableTaskStore.appData), isPresentingNewProjectView: .constant(true))
    }
}
