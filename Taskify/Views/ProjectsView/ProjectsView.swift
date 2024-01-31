//
//  ProjectsView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectsView: View {
    @EnvironmentObject var tasks: TasksStore
    @State private var isPresentingNewProjectView = false
    var body: some View {
        NavigationStack {
            List {
                ForEach($tasks.projects, id: \.self.wrappedValue) { $project in
                        NavigationLink(destination: ProjectDetailView(project: $project)) {
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
            NewProjectSheet(isPresentingNewProjectView: $isPresentingNewProjectView)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        tasks.projects.move(fromOffsets: source, toOffset: destination)
    }
    
}

#Preview {
    ProjectsView().environmentObject(TasksStore.testableTaskStore)
}
