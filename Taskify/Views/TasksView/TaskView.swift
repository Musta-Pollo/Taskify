//
//  TaskView.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

struct TaskView: View {
    var task: Todo?
    var appData: AppData
    
    var body: some View {
        let project = appData.projectById(projectId: task?.projectId)
        HStack {
            Image(systemName: "circle")
                .foregroundColor(project?.color.color ?? .gray)
                .padding(.trailing)
            Text(task?.name ?? "None")
            
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: Project.sampleProjects[0])
    }
}
