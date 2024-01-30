//
//  TaskTrackingView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TaskTrackingView: View {
    @Binding var todo : Todo
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TaskTrackingView(todo: .constant(Todo.sampleData[0]))
}
