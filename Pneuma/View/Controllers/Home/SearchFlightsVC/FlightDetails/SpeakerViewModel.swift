//
//  SpeakerViewModel.swift
//  Pneuma
//
//  Created by Ankita Thakur on 20/03/23.
//  Copyright © 2023 Kamaljeet Punia. All rights reserved.
//
import AVFoundation
import UIKit

class Speaker: NSObject, AVSpeechSynthesizerDelegate {
    let synthesizer = AVSpeechSynthesizer()
   
    func speak(msg: String) {
        synthesizer.delegate = self
        let utterance = AVSpeechUtterance(string: msg)

        utterance.rate = 0.57
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.2
        utterance.volume = 0.8

        let voice = AVSpeechSynthesisVoice(language: "en-US")

        utterance.voice = voice
        synthesizer.speak(utterance)
    }
}
