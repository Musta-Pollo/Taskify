//
//  TodoCard.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TodoCardView: View {
    @Binding var todo : Todo
    var body: some View {
        HStack {
            // Circle for completing the task
            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                
                .foregroundColor(todo.priority.color)
                
                .onTapGesture {
                    todo.isCompleted.toggle() // Toggle the completion status of the todo
                }
                .padding([.trailing])
            
            VStack(alignment: .leading) {
                // Title
                Text(todo.name)
                    .font(.headline)
                    
                
                if(todo.dateTime != nil){
                    // Description of deadline
                    Text("Due: \(deadlineDescription(todo.nonNullDateTime))")
                        .font(.footnote)
                }
            }

            Spacer()
        }
        }
    
    private func deadlineDescription(_ date: Date) -> String {
        // Format the deadline date as a string
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

#Preview {
    TodoCardView(todo: .constant(Todo.sampleData[0]))
}
