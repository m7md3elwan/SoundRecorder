//
//  RecordPermissionStatable.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation

protocol RecordPermissionStatable {
    var recordPermission: AVAudioSession.RecordPermission { get }
}

extension AVAudioSession: RecordPermissionStatable { }
