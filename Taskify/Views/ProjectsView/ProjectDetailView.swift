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
    @Binding var project : Project
    @EnvironmentObject var tasks : TasksStore
    @State private var editingProject = Project.emptyProject
    @State private var isPresentingEditView = false

    
    var body: some View {
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
                if tasks.projectHistory(projectId: project.id).isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                
                ForEach(tasks.projectHistory(projectId: project.id).map({ h in
                    h.id.uuidString
                })) { hId in
//                    let index = tasks.history.firstIndex(where: { h in h.id == history.id}) ?? 0
                    let id = UUID(uuidString: hId)
                    let history = tasks.historyForId(historyId: id)
                    NavigationLink(destination: HistoryView(history: $tasks.history[0])){
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.formattedDuration())
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
                    ProjectEditView(project: $editingProject)
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
    ProjectDetailView(project: .constant(Project.sampleProjects[0])).environmentObject(TasksStore.testableTaskStore)
}
