//
//  TodoEditView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TodoEditView: View {
    @Binding var todo: Todo
    @EnvironmentObject var tasks: TasksStore
    @State var hiddenDateTime : Date
//    init(todo: Todo, tasks: TasksStore, hiddenDateTime: Date) {
//        self.todo = todo
//        self.tasks = tasks
//        self.hiddenDateTime = hiddenDateTime
//    }
    var body: some View {
        Form {
            Section(header: Text("Default Info")) {
                TextField("Name", text: $todo.name)
                ProjectPicker(selectedProjectId: $todo.projectId)
                PriorityPicker(selectedPriority: $todo.priority)
            }
            Section(header: Text("Deadline")) {
                DatePickerOptional("Select Date", prompt: "Add Date", selection: $todo.dateTime)
                if(todo.dateTime !=  nil){
                    TimePickerOptionalView("Select Time", prompt: "Add Time", selection: $todo.dateTime)
                }
            }
        }
    }
    
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditView(todo: .constant(Todo.sampleData[0])).environmentObject(TasksStore.testableTaskStore)
    }
}
