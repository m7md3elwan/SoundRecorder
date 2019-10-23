//
//  MockMainRecordingRouter.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

@testable import iTranslateSample01

class MockMainRecordingRouter {
    struct MockResponses {
    }
    
    struct MocKCalls {
        var openAllRecordings: (() -> ())?
        var openPermissionRequest: (() -> ())?
    }
    
    var mockResponses = MockResponses()
    var mockCalls = MocKCalls()
    
    var viewController: UIViewController?
}

extension MockMainRecordingRouter: MainRecordingRouting {
    func openAllRecordings() {
        mockCalls.openAllRecordings?()
    }
    
    func openPermissionRequest(with model: PermissionRequest) {
        mockCalls.openPermissionRequest?()
    }
}
