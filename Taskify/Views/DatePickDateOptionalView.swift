//
//  DatePickDateOptionalView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct DatePickerOptional: View {
    let label: String
    let prompt: String
    let range: ClosedRange<Date>
    @Binding var date: Date?
    @State private var hiddenDate: Date
    @State private var showDate: Bool

    init(_ label: String, prompt: String, in range: ClosedRange<Date> = Date()...Date(timeIntervalSinceNow: 31536000), selection: Binding<Date?>) {
        self.label = label
        self.prompt = prompt
        self.range = range
        self._date = selection
        self._hiddenDate = State(initialValue: selection.wrappedValue ?? Date())
        self._showDate = State(initialValue: selection.wrappedValue != nil)
    }

    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                if showDate {
                    Button(action: {
                        showDate = false
                        date = nil
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    DatePicker("", selection: $hiddenDate, in: range, displayedComponents: [.date])
                        .labelsHidden()
                        .onChange(of: hiddenDate) { oldDate, newDate in
                            date = newDate
                        }
                        .preferredColorScheme(.dark)
                } else {
                    Button(action: {
                        showDate = true
                        
                        hiddenDate = date ?? Date().settingHourAndMinuteToZero()
                        date = hiddenDate
                    }) {
                        Text(prompt)
                    }
                    .frame(width: 120, height: 34)
//                    .buttonStyle(.bordered)
                    
//                    .background(RoundedRectangle(cornerRadius: 8).stroke())
                }
            }
        }
        .onChange(of: date) { oldValue, newValue in
                if newValue == nil {
                    showDate = false
                    hiddenDate = Date().settingHourAndMinuteToZero()
                } else {
                    showDate = true
                    hiddenDate = newValue ?? Date()
                }
        }
    }
}

struct DatePickerOptional_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerOptional("Pick Deadline", prompt: "Pick", selection: .constant(nil))
    }
}
