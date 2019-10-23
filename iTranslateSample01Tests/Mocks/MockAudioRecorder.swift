//
//  MockAudioRecorder.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

@testable import iTranslateSample01

class MockAudioRecorder {
    struct MockResponses {
        var isRecording = false
    }
    
    struct MocKCalls {
        var startRecording: (() -> ())?
        var finishRecording: (() -> ())?
    }
    
    var delegate: AudioRecorderDelegate?
    var mockResponses = MockResponses()
    var mockCalls = MocKCalls()
}

extension MockAudioRecorder: AudioRecording {
    var isRecording: Bool {
        return mockResponses.isRecording
    }
    
    func startRecording(to path: URL) {
        mockCalls.startRecording?()
    }
    
    func finishRecording() {
        mockCalls.finishRecording?()
    }
}
