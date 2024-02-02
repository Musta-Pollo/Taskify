//
//  EditHistoryView.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

struct EditHistoryView: View {
    @Binding var history: History
    @Binding var appData: AppData
    
    var body: some View {
        Form {
            Section(header: Text("Basic Info")) {
                DatePicker("Start", selection: $history.start, displayedComponents: [.date, .hourAndMinute])
                DatePicker("End", selection: $history.end, displayedComponents: [.date, .hourAndMinute])
                   
            }
            Section(header: Text("Tracked")) {
                ProjectPicker(selectedProjectId: $history.projectId, appData: $appData)
                    .onChange(of: history.projectId, {
                        history.taskId = nil
                    })
                TaskPicker(selectedTaskId: $history.taskId, appData: $appData, selectedProjectId: history.projectId, canPickNone: true)
            }
        }
        
    }
}

#Preview {
    EditHistoryView(history: .constant(History.sampleHistories[0]),appData: .constant(TasksStore.testableTaskStore.appData))
}
