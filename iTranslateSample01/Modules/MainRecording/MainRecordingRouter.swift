//
//  MainRecordingRouter.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import UIKit

class MainRecordingRouter: MainRecordingRouting {
    weak var viewController: UIViewController?
    
    func openAllRecordings() {
        if let recordingsView = RecordingsModuleFactory.makeModule() {
            viewController?.present(recordingsView, animated: true, completion: nil)
        }
    }
    
    func openPermissionRequest(with model: PermissionRequest) {
        if let permissionRequestView: PermissionRequestViewController = Storyboards.Main.instantiate()  {
            _ = permissionRequestView.view
            permissionRequestView.configure(model: model)
            viewController?.present(permissionRequestView, animated: true, completion: nil)
        }
    }
}
