//
//  Priority.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation
import SwiftUI

enum Priority : String, Codable, CaseIterable, Identifiable {
    case high
    case medium
    case low
    case none
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
    
}


extension Priority {
    var color: Color {
        switch self {
        case .high:
            return .red
        case .medium:
            return .yellow
        case .low:
            return .green
        case .none:
            return .gray
        }
    }
    var value : Int {
        switch self {
            case .high:
                return 1
            case .medium:
                return 2
            case .low:
                return 3
            case .none:
                return 4
        }
    }
}
