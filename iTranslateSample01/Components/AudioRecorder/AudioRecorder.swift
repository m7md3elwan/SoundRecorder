//
//  AudioRecorder.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation

class AudioRecorder: NSObject {
    
    // MARK:- Properties
    fileprivate var recorder:AVAudioRecorder?
    fileprivate var recordStateUpdateTimer: Timer?
    
    weak var delegate: AudioRecorderDelegate?
        
    var recorderTime: Double = 0
    var recorderAveragePower: Float = 0
    var recorderPeakPower: Float = 0
    
    var isRecording: Bool {
        return recorder?.isRecording ?? false
    }
    
    let recordSettings: [String: AnyObject] = [
        AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
        AVSampleRateKey: 44100.0 as AnyObject,
        AVNumberOfChannelsKey: 1 as AnyObject]
    
    // MARK:- Methods
    @objc func updateRecordState(){
        recorder?.updateMeters()
        
        guard let recorder = recorder else { return }
        recorderTime = recorder.currentTime
        recorderAveragePower = recorder.averagePower(forChannel: 0)
        recorderPeakPower = recorder.peakPower(forChannel: 0)
        
        delegate?.recordingStateUpdated(recorder: self, recorderTime: recorderTime, recorderAveragePower: recorderAveragePower)
    }
}

// MARK:- AudioRecording
extension AudioRecorder: AudioRecording {
    func startRecording(to path:URL) {
        finishRecording()
        do {
            
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
            
            recorder = try AVAudioRecorder(url: path, settings: recordSettings)
            recorder?.delegate = self
            recorder?.isMeteringEnabled = true
            recorder?.prepareToRecord()
            recorder?.record()
            recordStateUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(AudioRecorder.updateRecordState), userInfo: nil, repeats: true)
        } catch {
            delegate?.recordingEnded(recorder: self, error: error)
        }
    }
    
    func finishRecording(){
        self.recorder?.stop()
        self.recordStateUpdateTimer?.invalidate()
    }
}

// MARK:- AVAudioRecorderDelegate
extension AudioRecorder:AVAudioRecorderDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            delegate?.recordingEnded(recorder: self, error: nil)
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder,
                                          error: Error?) {
        delegate?.recordingEnded(recorder: self, error: error)
    }
}
