//
//  TasksView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TasksView: View {
    @Binding var appData: AppData
    @State private var isPresentingNewScrumView = false
    var body: some View {
        NavigationStack {
            List($appData.tasks.sortedTodos) { $task in
                NavigationLink(destination: TodoDetailView(todo: $task, appData: $appData)) {
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
    TasksView(appData: .constant(TasksStore.testableTaskStore.appData)).environmentObject(TasksStore.testableTaskStore)
}
