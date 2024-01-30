//
//  TodoDetailView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TodoDetailView: View {
    @Binding var todo : Todo
    var body: some View {
        Text(todo.name)
    }
}

#Preview {
    TodoDetailView(todo: .constant(Todo.sampleData[0]))
}
