//
//  TimerView.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI
import UICircularProgressRing

struct TimerView: View {
    @Binding var appData: AppData
    var project: Project?
    var task: Todo?
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var timerManager = ActivityTracker(currentProject: Project.sampleProjects[0], appData: .constant(TasksStore.testableTaskStore.appData)) // Example initialization
    @State private var isPresentingDurationPicker = false
    @State private var isShowingExitConfirmation = false

    
    init(appData: Binding<AppData>, project: Project?, task: Todo? = nil, isPresentingDurationPicker: Bool = false) {
        self._appData = appData
        self.project = project
        self.task = task
        self._timerManager = StateObject(wrappedValue: ActivityTracker(currentProject: project, currentTask: task, appData: appData))
        self.isPresentingDurationPicker = isPresentingDurationPicker
    }
    
    var body: some View {
        VStack {
            ZStack {
                CircularProgressView(progress: timerManager.progress, progressColor: project?.color.color ?? .gray) {
                    VStack {
                        Text(timerManager.timerString)
                            .font(.largeTitle)
                        
                        Button(action: {
                            isPresentingDurationPicker = true
                        }) {
                            Text("Change Duration")
                                .font(.caption)
                        }
                        .padding(.top, 4)
                    }
                }
                .padding([.leading, .trailing], 50)
            }
            
            Spacer() // This will push the content above and below it to the edges
            
            if timerManager.isRunning {
                HStack {
                    Button("Pause") {
                        timerManager.pause()
                    }
                    .buttonStyle(.bordered)
                    .padding(.trailing)
                    
                    Button("Stop ") {
                        timerManager.stop()
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                Button("Start") {
                    timerManager.start()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding([.top, .bottom], 125)
        .sheet(isPresented: $isPresentingDurationPicker) {
            DurationPickerView(selectedDuration: $timerManager.trackedDuration)
        }
        .confirmationDialog("Leave Tracking?", isPresented: $isShowingExitConfirmation, titleVisibility: .visible) {
            Button("Leave", role: .destructive) {
                timerManager.stop()
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("You have an ongoing tracking session. Leaving this page will stop the tracking.")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if timerManager.isRunning {
                        isShowingExitConfirmation = true
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        }
        .navigationBarHidden(false)
        .accentColor(project?.color.color ?? .gray)
        .navigationBarBackButtonHidden()
        .navigationTitle(task == nil ? project!.name : project == nil ? task!.name : (task!.name + ": " + project!.name))
//        .navigationBarItems(leading: Button("Back") {
//            // Action to navigate back
//        })
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(appData: .constant(AppData()), project: Project.sampleProjects[0], task: nil)
    }
}


#Preview {
    TimerView(appData: .constant(TasksStore.testableTaskStore.appData), project: Project.sampleProjects[0])
}


