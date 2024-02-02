//
//  HistoryView.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import SwiftUI

import SwiftUI

struct HistoryView: View {
    @Binding var history: History
    @State var isPresentingEditView = false
    @State var editingHistory = History.emptyHistory
    @Binding var appData: AppData
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading){
                Divider()
                    .padding(.bottom)
                Text(history.formattedDuration())
            }
        }
        .navigationTitle(Text(history.formattedDuration()))
        .padding()
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingHistory = history
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                EditHistoryView(history: $editingHistory, appData: $appData)
                    .navigationTitle(history.formattedDuration())
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                history = editingHistory
                            }
                            .disabled(editingHistory.projectId == nil && editingHistory.taskId == nil)
                        }
                    }
            }
        }}
}

#Preview {
    HistoryView(
        history: .constant(History.sampleHistories[0]), appData: .constant(TasksStore.testableTaskStore.appData))
}
