//
//  TasksView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var tasks: TasksStore
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: ()->Void
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing){
                List($tasks.tasks.sortedTodos) { $task in
                        NavigationLink(destination: TodoDetailView(todo: $task)) {
                            TodoCardView(todo: $task)
                        }
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
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .inactive { saveAction() }
        }
    }
    
}

#Preview {
    TasksView(saveAction: {}).environmentObject(TasksStore.testableTaskStore)
}
