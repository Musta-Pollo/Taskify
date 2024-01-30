//
//  PriorityView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct PriorityView: View {
    let priority: Priority
    
    var body: some View {
        HStack {
            Image(systemName: "flag.fill")
                .foregroundColor(priority.color)
                .padding(.trailing)
            Text(priority.name)
            
        }
    }
}

struct Priority_Previews: PreviewProvider {
    static var previews: some View {
        PriorityView(priority: Priority.medium)
    }
}
