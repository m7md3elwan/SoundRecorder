//
//  AudioPlayerDelegate.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

protocol AudioPlayerDelegate: class {
    func playingStateUpdated(player: AudioPlaying, currentTime: Double, duration: Double)
    func playingEnded(player: AudioPlaying, error: Error?)
}
