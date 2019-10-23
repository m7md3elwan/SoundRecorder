//
//  AudioRecording.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

protocol AudioRecording: class {
    var delegate: AudioRecorderDelegate? { set get }
    var isRecording: Bool { get }
    func startRecording(to path:URL)
    func finishRecording()
}
