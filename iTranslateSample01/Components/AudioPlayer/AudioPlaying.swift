//
//  AudioPlaying.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

protocol AudioPlaying: class {
    var delegate: AudioPlayerDelegate? { set get }
    func startPlaying(at path:URL)
    func finishPlaying()
}
