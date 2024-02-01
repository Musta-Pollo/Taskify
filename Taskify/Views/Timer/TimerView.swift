//
//  TimerView.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

struct TimerView: View {
    @Binding var appData: AppData
    @Binding var project: Project
    @Binding var task: Todo?
    
    @StateObject private var timerManager: ActivityTracker;
    @State private var isPresentingDurationPicker = false
    
    init(appData: Binding<AppData>, project: Binding<Project>, task: Binding<Todo?> = .constant(nil), timerManager: ActivityTracker? = nil, isPresentingDurationPicker: Bool = false) {
        self._appData = appData
        self._project = project
        self._task = task
        self._timerManager = StateObject(wrappedValue: ActivityTracker(currentProject: project.wrappedValue, currentTask: task.wrappedValue))
        self.isPresentingDurationPicker = isPresentingDurationPicker
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ProgressView(value: timerManager.progress, total: 1)
                        .progressViewStyle(.circular)
                        .scaleEffect(3) // Adjust the scale as needed
                    
                    VStack {
                        // Display the time string
                        Text(timerManager.timerString)
                            .font(.largeTitle)
                        
                        // Button to change the tracked duration
                        Button(action: {
                            isPresentingDurationPicker = true
                        }) {
                            Text("Change Duration")
                                .font(.body)
                        }
                        .padding(.top, 4)
                    }
                }
                .frame(width: 200, height: 200) // Adjust size as needed
                
                // Display the appropriate buttons based on the timer state
                if timerManager.isRunning {
                    Button("Pause") {
                        timerManager.pause()
                    }
                    Button("Stop") {
                        timerManager.stop()
                        // Logic to handle timer stop action
                    }
                } else {
                    Button("Start") {
                        timerManager.start()
                    }
                }
            }
            .sheet(isPresented: $isPresentingDurationPicker) {
                // Your custom duration picker view
                DurationPickerView(selectedDuration: $timerManager.trackedDuration)
            }
            .navigationTitle("Timer")
            .navigationBarItems(leading: Button("Back") {
                // Action to navigate back
            })
        }
    }
}

#Preview {
    TimerView(appData: .constant(TasksStore.testableTaskStore.appData), project: .constant(Project.sampleProjects[0]))
}
