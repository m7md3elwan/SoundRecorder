//
//  AudioRecorderDelegate.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

protocol AudioRecorderDelegate: class {
    func recordingStateUpdated(recorder: AudioRecording, recorderTime: Double, recorderAveragePower: Float)
    func recordingEnded(recorder: AudioRecording, error: Error?)
}
