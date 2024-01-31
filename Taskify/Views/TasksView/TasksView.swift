//
//  TasksView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var tasks: TasksStore
    @State private var isPresentingNewScrumView = false
    var body: some View {
        NavigationStack {
            List($tasks.tasks.sortedTodos) { $task in
                    NavigationLink(destination: TodoDetailView(todo: $task)) {
                        TodoCardView(todo: $task)
                }
            }
            .navigationTitle("Daily Tasks")
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
    TasksView().environmentObject(TasksStore.testableTaskStore)
}
