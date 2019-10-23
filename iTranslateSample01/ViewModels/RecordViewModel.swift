//
//  RecordViewModel.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import AVFoundation

struct RecordViewModel {
    let name: String
    let duration: String
    
    init(url: URL) {
        let asset = AVURLAsset(url: url)
        name = url.deletingPathExtension().lastPathComponent
        duration = asset.duration.seconds.getFormatedTimeText()
    }
}
