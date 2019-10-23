//
//  RecordingsService.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

protocol RecordingsServicing {
    var recordingsDirectory: URL { get }
    func getAllRecordings() -> [URL]
    func getRecordingUrl(name: String) -> URL
    func deleteAllRecordings()
    func deleteRecord(name: String)
    func deleteRecord(url: URL) -> Error?
}


final class RecordingsService: RecordingsServicing {
    
    struct Constanst {
        static let recordingsDirectoryName = "iTranlateRecordings"
    }
    
    lazy var recordingsDirectory: URL = {
        let mediaPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Constanst.recordingsDirectoryName).path
        try? FileManager.default.createDirectory(atPath:mediaPath, withIntermediateDirectories: true, attributes: nil)
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Constanst.recordingsDirectoryName)
    }()
   
    func getAllRecordings() -> [URL] {
        let enumerator = FileManager.default.enumerator(at: recordingsDirectory, includingPropertiesForKeys: nil)
        let recordings = enumerator?.allObjects as? [URL] ?? []
        return recordings.sorted{ $0.lastPathComponent > $1.lastPathComponent }
    }
    
    func getRecordingUrl(name: String) -> URL {
        return recordingsDirectory.appendingPathComponent(name)
    }
    
    func deleteAllRecordings() {
        let mediaPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Constanst.recordingsDirectoryName).path
        try? FileManager.default.removeItem(atPath: mediaPath)
    }
    
    func deleteRecord(name: String) {
        try? FileManager.default.removeItem(at: getRecordingUrl(name:name))
    }
    
    func deleteRecord(url: URL) -> Error? {
        do {
            try FileManager.default.removeItem(at: url)
            return nil
        } catch {
            return error
        }
    }
    
}
