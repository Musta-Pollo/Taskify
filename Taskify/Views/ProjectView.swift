//
//  ProjectView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ProjectView: View {
    let project: Project
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(project.colorColor)
                .padding(.trailing)
            Text(project.name)
            
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(project: Project.sampleProjects[0])
    }
}
