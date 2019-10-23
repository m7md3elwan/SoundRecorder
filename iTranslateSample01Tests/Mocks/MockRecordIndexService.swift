//
//  MockRecordIndexService.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

@testable import iTranslateSample01

class MockRecordIndexService {
    
    struct MockResponses {
        var dequeueNewRecordIndex = 0
    }
    
    var mockResponses = MockResponses()
}

extension MockRecordIndexService: RecordIndexServicing {
    func dequeueNewRecordIndex() -> Int {
        return mockResponses.dequeueNewRecordIndex
    }
}
