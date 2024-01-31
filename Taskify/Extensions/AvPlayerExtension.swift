//
//  AvPlayerExtension.swift
//  Taskify
//
//  Created by Jan Zimola on 30.01.2024.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let congratsPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "congrats", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
