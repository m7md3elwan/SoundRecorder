//
//  MainRecordingViewController.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/20/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

class MainRecordingViewController: UIViewController, Messagable {
        
    // MARK:- Properties
    var viewModel: MainRecordingViewModelType?

    // MARK: Outlets
    @IBOutlet weak var recordingButton: RecordingButton!
    
     // MARK:- Methods
    fileprivate func switchRecordButton(to state: RecordingState) {
        switch state {
        case .recording(let recordTimeText, let soundPower):
            self.switchRecordingButtonToRecordingState(button: self.recordingButton, recordText: recordTimeText, waveScale: soundPower)
        case .stopped:
            self.switchRecordingButtonToStoppedState(button: self.recordingButton)
        }
    }
    
    fileprivate func switchRecordingButtonToRecordingState(button: RecordingButton, recordText: String?, waveScale: CGFloat = 1) {
        button.setTitle(recordText, for: [])
        button.setBackgroundImage(UIImage(asset: .stop), for: [])
        button.WaveAnimationView.isHidden = false
        
        UIView.animate(withDuration: 0.15, animations: {
            button.WaveAnimationView.transform = CGAffineTransform(scaleX: waveScale, y: waveScale)
        })
    }
    
    fileprivate func switchRecordingButtonToStoppedState(button: RecordingButton) {
        button.setTitle(nil, for: [])
        button.setBackgroundImage(UIImage(asset: .record), for: [])
        
        UIView.animate(withDuration: 0.15, animations: {
            button.WaveAnimationView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { (completed) in
            button.WaveAnimationView.isHidden = true
        })
    }
    
    // MARK:- Actions
    @IBAction func recordButtonClicked(_ sender: RecordingButton) {
        viewModel?.recordButtonClicked()
    }
    
    @IBAction func showRecordingsButtonClicked(_ sender: UIButton) {
        viewModel?.showRecordingsButtonClicked()
    }
}

// MARK:- MainRecordingViewModelDelegate
extension MainRecordingViewController: MainRecordingViewModelDelegate {
    func recordStateUpdated(state: RecordingState) {
        switchRecordButton(to: state)
    }
    
    func errorOccured(error: Error) {
        switch error {
        case MainRecordingError.permissionDenied:
            showErrorMessage(text: MainRecordingError.permissionDenied.localizedDescription) {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                      UIApplication.shared.open(settingsUrl)
            }
        default:
            showErrorMessage(text: error.localizedDescription)
        }
    }
}
