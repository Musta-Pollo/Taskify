//
//  DurationPickerView.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

struct DurationPickerView: View {
    @Binding var selectedDuration: TimeInterval

    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Duration",
                    selection: $selectedDate,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()

                Button("Set Duration") {
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: selectedDate)
                    let minute = calendar.component(.minute, from: selectedDate)
                    selectedDuration = TimeInterval(hour * 3600 + minute * 60)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .navigationTitle("Select Duration")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear {
            initializePickerDate()
        }
    }

    private func initializePickerDate() {
        let initialDuration = selectedDuration
        let hours = Int(initialDuration) / 3600
        let minutes = Int(initialDuration) % 3600 / 60

        var components = DateComponents()
        components.hour = hours
        components.minute = minutes

        if let date = Calendar.current.date(from: components) {
            selectedDate = date
        }
    }
}


#Preview {
    DurationPickerView(selectedDuration: .constant(TimeInterval(3600)))
}
