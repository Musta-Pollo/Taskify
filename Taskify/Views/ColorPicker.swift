//
//  ColorPicker.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var selectedColor: ColorType

    var body: some View {
        Picker("Color", selection: $selectedColor) {
            ForEach(ColorType.allCases) { idColor in
                ColorView(color: idColor)
                    .tag(idColor)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker(selectedColor: .constant(ColorType.blue))
    }
}
