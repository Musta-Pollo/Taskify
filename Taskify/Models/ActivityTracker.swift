//
//  ActivityTracker.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import Foundation
import SwiftUI

@MainActor
final class ActivityTracker: ObservableObject {
    
    @Published var trackedDuration: TimeInterval = 25 * 60 // default to 25 minutes
    @Published var isRunning = false
    private var timer: Timer?
    private var startTime: Date?
    private var endTime: Date?
    
    
    
    // Computed property to calculate the progress
    var progress: Double {
        guard let startTime = startTime, isRunning else { return 0 }
        let elapsedTime = Date().timeIntervalSince(startTime)
        return min(elapsedTime / trackedDuration, 1) // Ensure progress does not exceed 1
    }
    
    // Computed property to get the remaining time as a formatted string
    var timerString: String {
        let remainingTime = max(trackedDuration - (Date().timeIntervalSince(startTime ?? Date())), 0)
        return formatTimeInterval(remainingTime)
    }
    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? ""
    }
    
    
    
    
    var currentProject: Project
    var currentTask: Todo?
    
    init(currentProject: Project, currentTask: Todo? = nil) {
        self.currentProject = currentProject
        self.currentTask = currentTask
    }
    
    func start() {
        startTime = Date()
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            // Use weak self to avoid strong reference cycles
                    guard let strongSelf = self else { return }
            
            // Use Task to explicitly run the code on the main actor
            Task { @MainActor in
                // Now it's safe to access `isRunning` and call `update()` because we are on the main actor
                if strongSelf.isRunning {
                    strongSelf.update()
                }
            }
        }
    }
    
    func pause() {
        stopTimer(createRecord: true)
    }
    
    func stop() {
        stopTimer(createRecord: true, reset: true)
    }
    
    private func stopTimer(createRecord: Bool, reset: Bool = false) {
        timer?.invalidate()
        timer = nil
        isRunning = false
        endTime = Date()
        
        if createRecord, let start = startTime, let end = endTime, end.timeIntervalSince(start) >= 60 {
            createHistoryRecord(start: start, end: end)
        }
        
        if reset {
//            trackedDuration = 25 * 60 // Reset to default duration
            startTime = nil
            endTime = nil
        }
    }
    
    private func update() {
        // This method can be used to update UI elements periodically if needed
        self.objectWillChange.send()
    }
    
    private func createHistoryRecord(start: Date, end: Date) {
        // Replace with your method to save history records
        let history = History(start: start, end: end, projectId: currentProject.id, taskId: currentTask?.id)
        print("History record created: \(history)")
        // Save `history` to your data store
    }
    
    func changeTrackedDuration(date: Date) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        trackedDuration = TimeInterval(hour * 3600 + minute * 60)
    }
}
