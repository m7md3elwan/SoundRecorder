//
//  RecordTableViewCell.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var recordNameLabel: UILabel!
    @IBOutlet weak var recordTimeLabel: UILabel!
    
    // MARK:- Methods
    func configure(viewModel: RecordViewModel) {
        recordNameLabel.text = viewModel.name
        recordTimeLabel.text = viewModel.duration
    }
}
