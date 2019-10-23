//
//  MockRecordingsService.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

@testable import iTranslateSample01

class MockRecordingsService {
    
    struct MockResponses {
        var getAllRecordings = [URL]()
        var recordingsDirectory = URL(fileURLWithPath: "")
        var getRecordingUrl = URL(fileURLWithPath: "")
        var deleteRecord: Error? = nil
    }
    
    var mockResponses = MockResponses()
    
}

extension MockRecordingsService: RecordingsServicing {
    var recordingsDirectory: URL {
        return mockResponses.recordingsDirectory
    }
    
    func getAllRecordings() -> [URL] {
        return mockResponses.getAllRecordings
    }
    
    func getRecordingUrl(name: String) -> URL {
        return mockResponses.getRecordingUrl
    }
    
    func deleteRecord(url: URL) -> Error? {
        return mockResponses.deleteRecord
    }
    
    func deleteAllRecordings() {
        
    }
    
    func deleteRecord(name: String) {
        
    }
}
