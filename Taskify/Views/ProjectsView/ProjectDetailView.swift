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
                        .foregroundColor(project.colorColor)
                }
                
            }
            Section(header: Text("History")) {
                
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
    ProjectDetailView(project: .constant(Project.sampleProjects[0]))
}
