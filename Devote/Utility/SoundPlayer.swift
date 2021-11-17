//
//  SoundPlayer.swift
//  Devote
//
//  Created by Piotr Szerszeń on 17/11/2021.
//

import Foundation
import AVFoundation

class SoundPlayer {

    private var audioPlayer: AVAudioPlayer?

    static let shared = SoundPlayer()

    func playSound(_ sound: Sound) {
        if let path = Bundle.main.path(forResource: "sound-\(sound)", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Could not find and play sound-\(sound).mp3")
            }
        }
    }

    enum Sound {
        case ding, rise, tap
    }
}

