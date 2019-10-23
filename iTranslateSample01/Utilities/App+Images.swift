//
//  File.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

// allowing images to Strongly typed to decrease nil image crashes with the help of unit-testing
enum ImageAsset: String, CaseIterable {
    case record = "record"
    case stop = "stop"
    case trash = "trash"
}

extension UIImage {
    convenience init?(asset image: ImageAsset) {
        self.init(named: image.rawValue)
    }
}
