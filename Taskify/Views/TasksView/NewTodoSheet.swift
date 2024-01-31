//
//  NewTodoSheet.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct NewTodoSheet: View {
    @State private var newTodo = Todo.emptyTodo
    @Binding var appData: AppData
    @Binding var isPresentingNewTodoView: Bool
    
    var body: some View {
        NavigationStack {
            TodoEditView(todo: $newTodo, appData: $appData)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewTodoView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            appData.tasks.append(newTodo)
                            isPresentingNewTodoView = false
                        }
                    }
                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoSheet(appData: .constant(TasksStore.testableTaskStore.appData), isPresentingNewTodoView: .constant(true))
    }
}
