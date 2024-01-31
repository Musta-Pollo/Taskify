//
//  TodoEditView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TodoEditView: View {
    @Binding var todo: Todo
    @Binding var appData: AppData
//    init(todo: Todo, tasks: TasksStore, hiddenDateTime: Date) {
//        self.todo = todo
//        self.tasks = tasks
//        self.hiddenDateTime = hiddenDateTime
//    }
    var body: some View {
        Form {
            Section(header: Text("Default Info")) {
                TextField("Name", text: $todo.name)
                ProjectPicker(selectedProjectId: $todo.projectId, appData: .constant(TasksStore.testableTaskStore.appData))
                PriorityPicker(selectedPriority: $todo.priority)
            }
            Section(header: Text("Deadline")) {
                DatePickerOptional("Select Date", prompt: "Add Date", selection: $todo.dateTime)
                if(todo.dateTime !=  nil){
                    TimePickerOptionalView("Select Time", prompt: "Add Time", selection: $todo.dateTime)
                }
            }
            Section(header: Text("Note")) {
                TextEditor(text: $todo.note)
                   .frame(minHeight: 10 * 24, alignment: .leading) // Assuming 24pt per line
                   .padding(4)
            }
        }
    }
    
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditView(todo: .constant(Todo.sampleData[0]), appData: .constant(TasksStore.testableTaskStore.appData))
    }
}
