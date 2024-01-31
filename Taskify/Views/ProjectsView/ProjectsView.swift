//
//  ProjectsView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectsView: View {
    @EnvironmentObject var tasks: TasksStore
    @State private var isPresentingNewScrumView = false
    var body: some View {
        NavigationStack {
            List($tasks.projects.sorted { p1, p2 in
                return p1.name.wrappedValue > p2.name.wrappedValue
            }) { $project in
                    NavigationLink(destination: ProjectDetailView(project: $project)) {
                        ProjectCardView(project: $project)
                }
            }
            .navigationTitle("Projects")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Task")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewTodoSheet(isPresentingNewTodoView: $isPresentingNewScrumView)
        }
    }
    
}

#Preview {
    ProjectsView().environmentObject(TasksStore.testableTaskStore)
}
