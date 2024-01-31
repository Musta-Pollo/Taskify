//
//  ProjectCardView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI
import AudioToolbox
import AVFoundation

struct ProjectCardView: View {
    @Binding var project : Project
    var body: some View {
        HStack {
            Image(systemName: "circle.fill" )
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(project.color.color)
                .padding([.trailing])
            
            Text(project.name)
                .font(.headline)
        
            Spacer()
        }
    }
}

#Preview {
    ProjectCardView(project: .constant(Project.sampleProjects[0]))
}
