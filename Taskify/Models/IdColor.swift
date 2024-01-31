//
//  IdColor.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI
import UIKit

struct IdColor: Identifiable, Hashable {
    let id: String
    let color: Color

    init(color: Color) {
        self.color = color
        self.id = color.name()
    }
    
    static func ==(lhs: IdColor, rhs: IdColor) -> Bool {
            return lhs.id == rhs.id
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
