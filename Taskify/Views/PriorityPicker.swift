//
//  PriorityPicker.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct PriorityPicker: View {
    @Binding var selectedPriority: Priority
    
    
    var body: some View {
        Picker("Priority", selection: $selectedPriority) {
            ForEach(Priority.allCases) { priority in
                PriorityView(priority: priority)
                    .tag(priority)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct PriorityPicker_Previews: PreviewProvider {
    static var previews: some View {
        PriorityPicker(selectedPriority: .constant(Priority.none))
    }
}
