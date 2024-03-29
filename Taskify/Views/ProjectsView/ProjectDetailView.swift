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
    
    @State var isPresentingHistoryAddView = false

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Basic Info")) {
                    NavigationLink(destination: TimerView(appData: $appData, project: project)) {
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

                Section(header: HStack {
                    Text("History")
                    Spacer()
                    Button(action: {
                        isPresentingHistoryAddView = true
                    }){
                        Image(systemName: "plus")
                                            .foregroundColor(.blue)
                    }
                }) {
                    if appData.projectHistory(projectId: project.id).isEmpty {
                        Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                    } else {
                        let projectHistories = appData.projectHistory(projectId: project.id)
                        ForEach(projectHistories, id: \.id) { history in
                            if let index = appData.history.firstIndex(where: { $0.id == history.id }) {
                                NavigationLink(destination: HistoryView(history:  $appData.history[index], appData: $appData)) {
                                    Text(history.formattedDuration())
                                }
                            }
                        }
                        
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
            .sheet(isPresented: $isPresentingHistoryAddView) {
                NewHistorySheet(appData: $appData, isPresentingNewHistoryView: $isPresentingHistoryAddView, initialProject: project)
            }
        }
    }
}


#Preview {
    ProjectDetailView(project: .constant(Project.sampleProjects[0]), appData: .constant(TasksStore.testableTaskStore.appData))
}
