//
//  ProjectDetailView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

//
//  TodoDetailView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectDetailView: View {
    @Binding var project: Project
    @Binding var appData: AppData
    @State private var editingProject = Project.sampleProjects[0]
    @State private var isPresentingEditView = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Basic Info")) {
                    NavigationLink(destination: ProjectTrackingView(project: $project)) {
                        Label("Track Project", systemImage: "play")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    }
                    
                    HStack {
                        Label("Color", systemImage: "paintpalette")
                        Spacer()
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(project.color.color)
                    }
                }

                Section(header: Text("History")) {
                    if appData.projectHistory(projectId: project.id).isEmpty {
                        Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                    } else {
////                        let projectHistories = tasks.projectHistory(projectId: project.id)
////                        ForEach(projectHistories, id: \.id) { history in
////                            if let index = tasks.history.firstIndex(where: { $0.id == history.id }) {
////                                NavigationLink(destination: HistoryView(history: $tasks.history[index])) {
////                                    Text(history.formattedDuration())
////                                }
////                            }
////                        }
////                        ForEach($tasks.projects) { $project in
////                                NavigationLink(destination: ProjectDetailView(project: $project)) {
////                                    ProjectCardView(project: $project)
////                            }
////                        }
                        
                    }
                }
            }
            .navigationTitle(project.name)
            .toolbar {
                Button("Edit") {
                    isPresentingEditView = true
                    editingProject = project
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                NavigationStack {
                    ProjectEditView(project: $editingProject, appData: $appData)
                        .navigationTitle(project.name)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                    project = editingProject
                                }
                            }
                        }
                }
            }
        }
    }
}


#Preview {
    ProjectDetailView(project: .constant(Project.sampleProjects[0]), appData: .constant(TasksStore.testableTaskStore.appData))
}
