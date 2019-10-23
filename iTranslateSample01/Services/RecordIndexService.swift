//
//  RecordIndexService.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

protocol RecordIndexServicing {
    func dequeueNewRecordIndex() -> Int
}

final class RecordIndexService: RecordIndexServicing {
    
    // MARK:- Constants
    struct Constants {
        static let newRecordName = "NewRecordName"
    }
    
    // MARK:- Properties
    static let shared = RecordIndexService()
    
    // MARK:- Methods
    func dequeueNewRecordIndex() -> Int {
        let lastIndex: Int = UserSettings.get(Constants.newRecordName) ?? 1
        incrementSavedIndex(lastIndex: lastIndex)
        return lastIndex
    }
    
    fileprivate func incrementSavedIndex(lastIndex: Int) {
        UserSettings.save(Constants.newRecordName, value: lastIndex + 1)
    }
}
