//
//  TaskifyApp.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

@main
struct TaskifyApp: App {
    @StateObject private var store = TasksStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            AppView(appData: $store.appData) {
                Task {
                    do {
                        try await store.save(appDataA: store.appData)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
            .environmentObject(store)
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.tasks = Todo.sampleData
                store.projects = Project.sampleProjects
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
            
        }
    }
}



