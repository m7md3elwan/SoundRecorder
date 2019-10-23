//
//  MockAudioPlayer.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

@testable import iTranslateSample01

class MockAudioPlayer {
    struct MockResponses {
        
    }
    
    struct MocKCalls {
        var startPlaying: ((URL) -> ())?
        var finishPlaying: (() -> ())?
    }
    
    var mockResponses = MockResponses()
    var mockCalls = MocKCalls()
    
    var delegate: AudioPlayerDelegate?
}

extension MockAudioPlayer: AudioPlaying {
    func startPlaying(at path: URL) {
        mockCalls.startPlaying?(path)
    }
    
    func finishPlaying() {
        mockCalls.finishPlaying?()
    }
}
