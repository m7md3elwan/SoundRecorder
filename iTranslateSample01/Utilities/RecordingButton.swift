//
//  RecordingButton.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/20/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

class RecordingButton: UIButton {
    
    @IBInspectable var waveColor: UIColor = UIColor.red
    
    lazy var WaveAnimationView: UIView = {
        let WaveAnimationView = UIView(frame: self.bounds)
        WaveAnimationView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        WaveAnimationView.layer.cornerRadius = self.frame.size.width/2
        WaveAnimationView.backgroundColor = UIColor.clear
        WaveAnimationView.layer.borderColor = waveColor.cgColor
        WaveAnimationView.layer.borderWidth = 1.0
        WaveAnimationView.isUserInteractionEnabled = false
        self.addSubview(WaveAnimationView)
        return WaveAnimationView
    }()
}
