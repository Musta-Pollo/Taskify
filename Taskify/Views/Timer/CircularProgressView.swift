//
//  CircularProgressView.swift
//  Taskify
//
//  Created by Jan Zimola on 01.02.2024.
//

import SwiftUI

struct CircularProgressView<Content: View>: View {
    var progress: Double // Expected to be between 0 and 1
    let content: Content // The child view to display at the center

    private let lineWidth: CGFloat = 5
    var progressColor = Color.blue
    private let backgroundColor = Color.gray.opacity(0.2)

    init(progress: Double,  progressColor: Color = Color.blue,  @ViewBuilder content: () -> Content) {
        self.progress = progress
        self.content = content()
        self.progressColor = progressColor
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(backgroundColor)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
        .overlay(
            content
        )
    }
}

// Example usage with a Text view at the center
struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.7) {
            Text("50%")
                .font(.headline)
        }
        .frame(width: 100, height: 100)
    }
}
