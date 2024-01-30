//
//  TodoDetailView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TodoDetailView: View {
    @Binding var todo : Todo
    @EnvironmentObject var tasks : TasksStore
    @State private var editingTodo = Todo.emptyTodo
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Basic Info")) {
                NavigationLink(destination: TaskTrackingView(todo: $todo)) {
                    Label("Track Task", systemImage: "play")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
               
                    HStack {
                        Text("Project")
                        Spacer()
                        if(todo.projectId != nil){
                            ProjectView(project: tasks.projectByIdNonNull(projectId: todo.projectId))
                        } else {
                            Text("None")
                                .opacity(0.6)
                        }
                    }
                    HStack {
                        Text("Priority")
                        Spacer()
                        PriorityView(priority: todo.priority)
                            .opacity(0.6)
                    }
            }
            Section(header: Text("Deadline")) {
                HStack {
                    Label("Date", systemImage: "calendar")
                    Spacer()
                    if(todo.dateTime != nil){
                        Text(todo.nonNullDateTime.formattedDate())
                            .opacity(0.6)
                    } else {
                        Text("None")
                            .opacity(0.6)
                    }
                }
                if(todo.dateTime != nil && todo.nonNullDateTime.isTimeSet){
                    HStack {
                        Label("Time", systemImage: "clock")
                        Spacer()
                        Text(todo.nonNullDateTime.formattedTime())
                            .opacity(0.6)
                    }
                }
            }
            Section(header: Text("Note")){
                ScrollView {
                    Text(todo.note)
                                .padding()
                        }
            }
//            Section(header: Text("History")) {
//                if scrum.history.isEmpty {
//                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
//                }
//                ForEach(scrum.history) { history in
//                    NavigationLink(destination: HistoryView(history: history)) {
//                        HStack {
//                            Image(systemName: "calendar")
//                            Text(history.date, style: .date)
//                        }
//                    }
//                }
//            }
        }
        .navigationTitle(todo.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingTodo = todo
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                TodoEditView(todo: $editingTodo)
                    .navigationTitle(todo.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                todo = editingTodo
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    TodoDetailView(todo: .constant(Todo.sampleData[0]))
}