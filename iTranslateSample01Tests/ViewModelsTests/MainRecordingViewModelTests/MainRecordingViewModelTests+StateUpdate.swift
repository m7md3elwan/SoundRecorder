//
//  MainRecordingViewModelTests+StateUpdate.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import XCTest

@testable import iTranslateSample01

// MARK:- StateUpdate Tests
extension MainRecordingViewModelTests {
    
    func assertPower(power: Float, expectedNormalizedValue: CGFloat) {
        mockDelegate.mockCalls.recordStateUpdated = { (state) in
            switch state {
            case .recording(_,let soundPower):
                XCTAssertTrue(expectedNormalizedValue == soundPower)
            default: break
            }
        }
    }
    
    func test_normalizingPower() {
        mockAudioRecorder.mockResponses.isRecording = true
        
        var power: Float = -120 // Lowest Sound
        assertPower(power: power, expectedNormalizedValue: 1)
        viewModel.recordingStateUpdated(recorder: mockAudioRecorder, recorderTime: 0, recorderAveragePower: power)
        
        power = -60
        assertPower(power: power, expectedNormalizedValue: 1)
        viewModel.recordingStateUpdated(recorder: mockAudioRecorder, recorderTime: 0, recorderAveragePower: power)
        
        power = -40
        assertPower(power: power, expectedNormalizedValue: 1.1666666666666665)
        viewModel.recordingStateUpdated(recorder: mockAudioRecorder, recorderTime: 0, recorderAveragePower: power)
        
        power  = 0 // Highest Sound
        assertPower(power: power, expectedNormalizedValue: 1.5)
        viewModel.recordingStateUpdated(recorder: mockAudioRecorder, recorderTime: 0, recorderAveragePower: power)
    }
}
