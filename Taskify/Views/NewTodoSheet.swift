//
//  NewTodoSheet.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct NewTodoSheet: View {
    @State private var newTodo = Todo.emptyTodo
    @EnvironmentObject var tasks: TasksStore
    @Binding var isPresentingNewTodoView: Bool
    
    var body: some View {
        NavigationStack {
            TodoEditView(todo: $newTodo)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewTodoView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            tasks.tasks.append(newTodo)
                            isPresentingNewTodoView = false
                        }
                    }
                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoSheet(isPresentingNewTodoView: .constant(true)).environmentObject(TasksStore())
    }
}
