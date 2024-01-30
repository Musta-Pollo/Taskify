//
//  DeadlinePickerView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct DeadlinePickerView: View {
    @State private var deadlineDate: Date?
    @State private var deadlineTime: Date?

    var body: some View {
        Form {
            Section(header: Text("Deadline")) {
                DatePickerOptional("Select Date", prompt: "Add Date", selection: $deadlineDate)
                
//
//                // Show the time picker only if a date is selected
//                if let selectedDate = deadlineDate {
//                    DatePicker("Select Time", selection: $deadlineTime, default: selectedDate), displayedComponents: .hourAndMinute)
//                }
            }
        }
    }
}

struct DeadlinePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DeadlinePickerView()
    }
}
