//
//  NewHistorySheet.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

struct NewHistorySheet: View {
    @State private var newHistory = History.emptyHistory
    @Binding var appData: AppData
    @Binding var isPresentingNewHistoryView: Bool
    
    var initialProject : Project?
    var initialTask: Todo?
    
    init(newHistory: History = History.emptyHistory, appData: Binding<AppData>, isPresentingNewHistoryView: Binding<Bool>, initialProject: Project? = nil, initialTask: Todo? = nil) {
        var newH = newHistory
        newH.projectId = initialProject?.id
        newH.taskId = initialTask?.id
        self._newHistory = State(initialValue: newH)
        self._appData = appData
        self._isPresentingNewHistoryView = isPresentingNewHistoryView
        self.initialProject = initialProject
        self.initialTask = initialTask
    }
    
    var body: some View {
        NavigationStack {
            EditHistoryView(history: $newHistory, appData: $appData)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewHistoryView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            appData.history.append(newHistory)
                            isPresentingNewHistoryView = false
                        }
                        .disabled(newHistory.projectId == nil && newHistory.taskId == nil)
                    }
                }
        }
    }
}

struct NewHistorySheet_Previews: PreviewProvider {
    static var previews: some View {
        NewHistorySheet(appData: .constant(TasksStore.testableTaskStore.appData), isPresentingNewHistoryView: .constant(true))
    }
}
