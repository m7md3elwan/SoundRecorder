//
//  Double+FormatedTimeText.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

extension Double {
    // MARK:- Constants
    struct Constants {
        static let twoDigitFormat = "%02d"
    }
    
    func getFormatedTimeText(timeFormat: String = Constants.twoDigitFormat) -> String {
        let divider: Double = 60
        let minutes = Int(self / divider)
        let seconds = Int(self.truncatingRemainder(dividingBy: divider))
        return "\(String(format: timeFormat, minutes)):\(String(format: timeFormat, seconds))"
    }
}
