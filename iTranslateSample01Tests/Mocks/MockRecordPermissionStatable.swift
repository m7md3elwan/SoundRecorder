//
//  MockRecordPermissionStatable.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation

@testable import iTranslateSample01

class MockRecordPermissionStatable {
    struct MockResponses {
        var recordPermission = AVAudioSession.RecordPermission.granted
    }
    
    var mockResponses = MockResponses()
}

extension MockRecordPermissionStatable: RecordPermissionStatable {
    var recordPermission: AVAudioSession.RecordPermission {
        return mockResponses.recordPermission
    }
}
