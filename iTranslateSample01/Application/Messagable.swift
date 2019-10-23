//
//  Messagable.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

protocol Messagable: class {    
    func showSuccessMessage(text: String?, completion: (() -> ())?)
    func showErrorMessage(text: String?, completion: (() -> ())?)
}

extension Messagable where Self: UIViewController {
    func showSuccessMessage(text: String?, completion: (() -> ())? = nil) {
        func showAlert(text: String, completion: (() -> ())? = nil ) {
            let alertController = UIAlertController(title: nil, message:text, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (action) in
                completion?()
            }
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showErrorMessage(text: String?, completion: (() -> ())? = nil) {
        func showAlert(text: String, completion: (() -> ())? = nil ) {
            let alertController = UIAlertController(title: nil, message:text, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (action) in
                completion?()
            }
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
