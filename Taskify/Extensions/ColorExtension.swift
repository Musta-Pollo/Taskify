//
//  ColorExtension.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation
import SwiftUI

extension Color {
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
}
