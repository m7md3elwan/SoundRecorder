//
//  UIView+CornerRadius.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/20/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius}
        set {
            layer.cornerRadius =  newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
