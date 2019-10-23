//
//  RecordingState.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

enum RecordingState {
    case recording(recordTimeText: String, soundPower: CGFloat)
    case stopped(error: Error?)
}
