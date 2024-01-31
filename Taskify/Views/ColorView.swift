//
//  ColorView.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ColorView: View {
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(color)
                .padding(.trailing)
            Text(color.name())
            
        }
    }
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(color: .blue)
    }
}
