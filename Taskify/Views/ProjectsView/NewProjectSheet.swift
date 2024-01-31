//
//  NewProjectSheet.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import SwiftUI

struct NewProjectSheet: View {
    @State private var newProject = Project.emptyProject
    @EnvironmentObject var appData: TasksStore
    @Binding var isPresentingNewProjectView: Bool
    
    var body: some View {
        NavigationStack {
            ProjectEditView(project: $newProject)
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
        NewProjectSheet(isPresentingNewProjectView: .constant(true)).environmentObject(TasksStore())
    }
}
