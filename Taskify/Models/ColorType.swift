//
//  ColorType.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import SwiftUI

enum ColorType: CaseIterable, Identifiable, Hashable, Codable {
    case red
    case green
    case blue
    case orange
    case yellow
    case pink
    case purple
    case gray
    case black
    case white

    var id: Self { self }

    var name: String {
        switch self {
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        case .orange:
            return "Orange"
        case .yellow:
            return "Yellow"
        case .pink:
            return "Pink"
        case .purple:
            return "Purple"
        case .gray:
            return "Gray"
        case .black:
            return "Black"
        case .white:
            return "White"
        }
    }

    var color: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .pink:
            return .pink
        case .purple:
            return .purple
        case .gray:
            return .gray
        case .black:
            return .black
        case .white:
            return .white
        }
    }
}
