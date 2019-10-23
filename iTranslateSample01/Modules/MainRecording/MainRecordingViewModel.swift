//
//  MainRecordingViewModel.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/20/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class MainRecordingViewModel {

    // MARK:- Constants
    struct Constants {
        static let twoDigitFormat = "%02d"
        static let recordPermissionTitle = "Microphone"
        static let recordPermissionDescription = "In order to use voice to voice conversation, iTranslate needs your permission to use your iPhone’s microphone."
        static let recordNameFormat = "Recording \(recordIndexPlaceHolder).m4a"
        static let recordIndexPlaceHolder = "#index#"
    }
    
    // MARK:- Properties
    var recorder: AudioRecording
    var service: RecordingsServicing
    var recordPermissionStateProvider: RecordPermissionStatable
    var router: MainRecordingRouting
    var recordIndexService: RecordIndexServicing
    weak var delegate: MainRecordingViewModelDelegate?
    
    // MARK:- Initializer
    init(delegate: MainRecordingViewModelDelegate?,
         service: RecordingsServicing,
         router: MainRecordingRouting,
         recorder: AudioRecording,
         recordIndexService: RecordIndexServicing,
         recordPermissionStateProvider: RecordPermissionStatable = AVAudioSession.sharedInstance()) {
        self.delegate = delegate
        self.service = service
        self.router = router
        self.recorder = recorder
        self.recordPermissionStateProvider = recordPermissionStateProvider
        self.recordIndexService = recordIndexService
        recorder.delegate = self
    }
    
    // MARK:- Methods
    fileprivate func getNormalizedRecordPower(from power: Float, maxDisciples: Double = 120) -> CGFloat {
        let audioPercentage = (Double(power) + maxDisciples) / maxDisciples
        let meanPercentage = 0.5
        return max(1, CGFloat(audioPercentage - meanPercentage) + 1)
    }
    
    func dequeueNewRecordName(newIndex: Int) -> String {
        return Constants.recordNameFormat.replacingOccurrences(of: Constants.recordIndexPlaceHolder, with: "\(newIndex)")
    }
    
    fileprivate func toggleRecordingState(isRecording: Bool) {
        if isRecording {
            recorder.finishRecording()
        } else {
            let recordName = dequeueNewRecordName(newIndex:  recordIndexService.dequeueNewRecordIndex())
            recorder.startRecording(to: service.getRecordingUrl(name: recordName))
        }
    }
    
    fileprivate func requestUserRecordPermission() {
        let permissionRequest = PermissionRequest(image: UIImage(asset: .record)!.withRenderingMode(.alwaysTemplate),
                                                  title: Constants.recordPermissionTitle,
                                                  description: Constants.recordPermissionDescription,
                                                  allowCompletion: {
                                                    AVAudioSession.sharedInstance().requestRecordPermission() { [weak self] (allowed: Bool) -> Void  in
                                                        guard let self = self else { return }
                                                        self.recordButtonClicked()
                                                    }
        })
        
        router.openPermissionRequest(with: permissionRequest)
    }
}

// MARK:- MainRecordingViewModelType
extension MainRecordingViewModel: MainRecordingViewModelType {
    func showRecordingsButtonClicked() {
        router.openAllRecordings()
    }
    
    func recordButtonClicked() {
        switch recordPermissionStateProvider.recordPermission {
        case .granted:
            Dispatch.onMainThread {
                self.toggleRecordingState(isRecording: self.recorder.isRecording)
            }
        case .denied:
            delegate?.errorOccured(error: MainRecordingError.permissionDenied)
        case .undetermined:
             requestUserRecordPermission()
        @unknown default:
            requestUserRecordPermission()
        }
    }
}

// MARK:- AudioRecorderDelegate
extension MainRecordingViewModel: AudioRecorderDelegate {
    func recordingStateUpdated(recorder: AudioRecording, recorderTime: Double, recorderAveragePower: Float) {
        guard recorder.isRecording else { return }
        delegate?.recordStateUpdated(state: RecordingState.recording(recordTimeText: recorderTime.getFormatedTimeText(), soundPower: getNormalizedRecordPower(from: recorderAveragePower)))
    }
    
    func recordingEnded(recorder: AudioRecording, error: Error?) {
        delegate?.recordStateUpdated(state: RecordingState.stopped(error: error))
    }
}



