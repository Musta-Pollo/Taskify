//
//  ColorExtension.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation
import SwiftUI

extension Color {
    static var predefinedIdColors: [IdColor]{
        return Color.predefinedColors.map { IdColor(color: $0) }
    }
    var isDark: Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return false
        }
        
        let lum = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return lum < 0.5
    }
    
    var textColor: Color {
        return isDark ? .white : .black
    }
    static var predefinedColors: [Color] {
            return [.red, .green, .blue, .orange, .yellow, .pink, .purple, .gray, .black, .white]
    }
    
    var colorId: String {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return "\(red)-\(green)-\(blue)"
        }
        return "unknown"
    }
    
static let standardColors: [Color: String] = [
       .red: "Red",
       .green: "Green",
       .blue: "Blue",
       .orange: "Orange",
       .yellow: "Yellow",
       .pink: "Pink",
       .purple: "Purple",
       .gray: "Gray",
       .black: "Black",
       .white: "White"
   ]

   static let nameToColor: [String: Color] = [
       "Red": .red,
       "Green": .green,
       "Blue": .blue,
       "Orange": .orange,
       "Yellow": .yellow,
       "Pink": .pink,
       "Purple": .purple,
       "Gray": .gray,
       "Black": .black,
       "White": .white
   ]
    
    func name() -> String {
            

        for (color, name) in Color.standardColors {
                if color == self {
                    return name
                }
            }

            return "Uknown"
        }
}
