//
//  AppView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct AppView: View {
    @Binding var appData: AppData
    @Environment(\.scenePhase) private var scenePhase
    @State private var selectedTab: Int = 0
    let saveAction: ()->Void

    var body: some View {
        TabView(selection: $selectedTab) {
            TasksView(appData: $appData)
                .tabItem {
                    Label("Tasks", systemImage: "list.bullet")
                }
                .tag(0)

            ProjectsView(appData: $appData)
                .tabItem {
                    Label("Projects", systemImage: "folder")
                }
                .tag(1)
        } 
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .inactive { saveAction() }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(appData: .constant(TasksStore.testableTaskStore.appData), saveAction: {})
    }
}

