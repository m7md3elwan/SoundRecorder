//
//  RecordingsViewModel.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import UIKit

class RecordingsViewModel {
    
    // MARK:- Properties
    var service: RecordingsServicing
    var player: AudioPlaying
    weak var delegate: RecordingsViewModelDelegate?
    
    private var recordings = [Record](){
        didSet {
            delegate?.recordingsUpdated()
        }
    }
    
    // MARK:- Initializer
    init(delegate: RecordingsViewModelDelegate?,
         service: RecordingsServicing,
         player: AudioPlaying) {
        self.delegate = delegate
        self.service = service
        self.player = player
        self.player.delegate = self
    }
    
    deinit {
        self.player.finishPlaying()
    }
    
    // MARK:- Methods
    func userHasDeleteRecordsPermission() -> Bool {
        return true
    }
}

// MARK:- MainRecordingViewModelType
extension RecordingsViewModel: RecordingsViewModelType {
    func viewLoaded() {
        recordings = service.getAllRecordings()
    }
    
    func numbetOfRecordings() -> Int {
        return recordings.count
    }
    
    func recordViewModelAt(index: Int) -> RecordViewModel? {
        guard index < recordings.count && index >= 0 else { return nil }
        return RecordViewModel(url: recordings[index])
    }
    
    func userDidSelectItem(at index: Int) {
        guard index < recordings.count && index >= 0 else { return }
        player.startPlaying(at: recordings[index])
        delegate?.showAudioPlayer(viewModel: RecordViewModel(url: recordings[index]))
    }
    
    func editActionsForItemAt(index: Int) -> [EditActionViewModel] {
        guard index < recordings.count && index >= 0 else { return [] }
        var actions = [EditActionViewModel]()
        if userHasDeleteRecordsPermission() {
            let action = EditActionViewModel(title: nil, image: UIImage(asset: .trash)!, backgroundColor: .redOrange, completion: { [weak self] in
                guard let self = self else { return }
                _ = self.service.deleteRecord(url: self.recordings[index])
                self.viewLoaded()
            })
            actions.append(action)
        }
        return actions
    }
}

extension RecordingsViewModel: AudioPlayerDelegate {
    func playingStateUpdated(player: AudioPlaying, currentTime: Double, duration: Double) {
        delegate?.playingStateUpdated(currentTime: currentTime.getFormatedTimeText(), duration: duration.getFormatedTimeText(), percentage: currentTime/duration)
    }
    
    func playingEnded(player: AudioPlaying, error: Error?) {
        delegate?.hideAudioPlayer()
    }
}
