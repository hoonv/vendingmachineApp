//
//  Speaker.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/21.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation
import AVFoundation

class Speaker {

    private static let speech = AVSpeechSynthesizer()

    private init() {
    }
    
    public static func speak(text: String, language: String = "ko-KR") {
        let utterane = AVSpeechUtterance(string: text)
        utterane.voice = AVSpeechSynthesisVoice(language: language)
        utterane.pitchMultiplier = 1
        utterane.volume = 1
        speech.speak(utterane)
    }
}
