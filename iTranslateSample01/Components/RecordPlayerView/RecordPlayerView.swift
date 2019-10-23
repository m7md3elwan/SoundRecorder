//
//  RecordPlayerView.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

class RecordPlayerView: UIView {

    // MARK: Outlets
    @IBOutlet var trackNameLabel: UILabel!
    
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    
    @IBOutlet var slider: UISlider!
    
    // MARK:- UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}
