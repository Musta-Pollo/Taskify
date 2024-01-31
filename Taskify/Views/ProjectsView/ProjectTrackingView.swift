//
//  ProjectTrackingView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectTrackingView: View {
    @Binding var project : Project
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ProjectTrackingView(project: .constant(Project.sampleProjects[0]))
}
