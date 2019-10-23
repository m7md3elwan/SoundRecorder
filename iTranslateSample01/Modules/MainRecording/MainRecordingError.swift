//
//  MainRecordingError.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

enum MainRecordingError: Error {
    case permissionDenied
    
    var localizedDescription: String {
        switch self {
        case .permissionDenied:
            return "Please enable recording permission from Settings"
        }
    }
}
