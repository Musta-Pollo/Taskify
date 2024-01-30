//
//  TimePickerOptionalView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct TimePickerOptionalView: View {
    let label: String
    let prompt: String
    @Binding var time: Date?
    @State private var hiddenTime: Date
    @State private var showTime: Bool

    init(_ label: String, prompt: String, selection: Binding<Date?>) {
        self.label = label
        self.prompt = prompt
        self._time = selection
        self._hiddenTime = State(initialValue: selection.wrappedValue ?? Date())
        self._showTime = State(initialValue: selection.wrappedValue?.isTimeSet ?? false)
    }

    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                if showTime {
                    Button(action: {
                        showTime = false
                        time = time?.settingHourAndMinuteToZero()
                        
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    DatePicker("", selection: $hiddenTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: hiddenTime) { oldDate, newDate in
                            time = newDate
                        }
                } else {
                    Button(action: {
                        showTime = true
                        hiddenTime = (time ?? Date()).nextAppropriateTime()
                        time = hiddenTime
                    }) {
                        Text(prompt)
                    }
                    .frame(width: 120, height: 34)
                }
            }
        }
    }
}

struct TimePickerOptional_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerOptionalView("Pick Time", prompt: "Pick", selection: .constant(nil))
    }
}
