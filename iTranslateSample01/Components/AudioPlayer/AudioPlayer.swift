//
//  AudioPlayer.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject {
    
    // MARK:- Properties
    fileprivate var player:AVAudioPlayer?
    fileprivate var playingStateUpdateTimer: Timer?
    weak var delegate: AudioPlayerDelegate?
    
    // MARK:- Methods
    @objc func updatePlayingState(){
        player?.updateMeters()
        guard let player = player else { return }
        delegate?.playingStateUpdated(player: self, currentTime: player.currentTime, duration: player.duration)
    }
}

// MARK:- AudioPlaying
extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            delegate?.playingEnded(player: self, error: nil)
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        delegate?.playingEnded(player: self, error: error)
    }
}

// MARK:- AudioPlaying
extension AudioPlayer: AudioPlaying {
    func startPlaying(at path: URL) {
        finishPlaying()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: path)
            player?.delegate = self
            player?.play()
            player?.volume = 1
            playingStateUpdateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(AudioPlayer.updatePlayingState), userInfo: nil, repeats: true)
        } catch {
            delegate?.playingEnded(player: self, error: error)
        }
    }
    
    func finishPlaying() {
        player?.stop()
        playingStateUpdateTimer?.invalidate()
    }
}
