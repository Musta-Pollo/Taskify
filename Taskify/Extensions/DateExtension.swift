//
//  DateExtension.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation


extension Date {
    var isTimeSet: Bool {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: self)
            return (components.hour ?? 0) != 0 || (components.minute ?? 0) != 0
        }
    
    func settingHourAndMinuteToZero() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        return calendar.date(from: components) ?? self
    }
    func nextAppropriateTime() -> Date {
        let calendar = Calendar.current
        let timeOptions = [8, 11, 14] // Hours of the day for the options

        var closestTime = self
        var isTimeSet = false

        for hour in timeOptions {
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            components.hour = hour
            components.minute = 0
            components.second = 0
            
            if let optionTime = calendar.date(from: components), optionTime > Date.now {
                closestTime = optionTime
                isTimeSet = true
                break
            }
        }

        if !isTimeSet {
            // If all options are in the past, move to the next day and set the time to the first option
            closestTime = calendar.date(byAdding: .day, value: 1, to: closestTime)!
            closestTime = calendar.date(bySettingHour: timeOptions[0], minute: 0, second: 0, of: closestTime)!
        }

        return closestTime
    }
}
