//
//  MockMainRecordingViewModelDelegate.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

@testable import iTranslateSample01

class MockMainRecordingViewModelDelegate {
    struct MockResponses {
    }
    
    struct MocKCalls {
        var recordStateUpdated: ((RecordingState) -> ())?
        var errorOccured: ((Error) -> ())?
    }
    
    var mockResponses = MockResponses()
    var mockCalls = MocKCalls()
}

extension MockMainRecordingViewModelDelegate: MainRecordingViewModelDelegate {
    func recordStateUpdated(state: RecordingState) {
        mockCalls.recordStateUpdated?(state)
    }
    
    func errorOccured(error: Error) {
        mockCalls.errorOccured?(error)
    }
}
