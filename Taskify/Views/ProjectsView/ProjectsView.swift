//
//  ProjectsView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectsView: View {
    @Binding var appData: AppData
    @State private var isPresentingNewProjectView = false
    var body: some View {
        NavigationStack {
            List {
                ForEach($appData.projects) { $project in
                    NavigationLink(destination: ProjectDetailView(project: $project, appData: $appData)) {
                            ProjectCardView(project: $project)
                    }
                }
                .onMove(perform: move)
            }
            .navigationTitle("Projects")
            .toolbar {
                Button(action: {
                    isPresentingNewProjectView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Task")
            }
        }
        .sheet(isPresented: $isPresentingNewProjectView) {
            NewProjectSheet( appData: $appData, isPresentingNewProjectView: $isPresentingNewProjectView)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        appData.projects.move(fromOffsets: source, toOffset: destination)
    }
    
}

#Preview {
    ProjectsView( appData: .constant(TasksStore.testableTaskStore.appData))
}
