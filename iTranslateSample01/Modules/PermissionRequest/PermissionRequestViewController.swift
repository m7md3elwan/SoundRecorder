//
//  PermissionRequestViewController.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

struct PermissionRequest {
    var image: UIImage
    var title: String
    var description: String
    var allowCompletion: () -> ()
}

class PermissionRequestViewController: UIViewController {
    
    // MARK:- Properties
    var model: PermissionRequest?
        
    // MARK: Outlets
    @IBOutlet var permissionImageView: UIImageView!
    @IBOutlet var permissionTitleLabel: UILabel!
    @IBOutlet var permissionDescriptionLabel: UILabel!
    
    // MARK:- Methods
    func configure(model: PermissionRequest) {
        self.model = model
        permissionImageView.image = model.image
        permissionTitleLabel.text = model.title
        permissionDescriptionLabel.text = model.description
    }
    
    // MARK: Actions
    @IBAction func AllowButtonClicked(_ sender: UIButton) {
        model?.allowCompletion()
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func LaterButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
