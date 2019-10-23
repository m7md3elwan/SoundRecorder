//
//  MainRecordingContract.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/20/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import UIKit

protocol MainRecordingViewModelDelegate: class {
    func recordStateUpdated(state: RecordingState)
    func errorOccured(error: Error)
}

protocol MainRecordingViewModelType {
    func recordButtonClicked()
    func showRecordingsButtonClicked()
}

protocol MainRecordingRouting {
    var viewController: UIViewController? { get set }
    
    func openAllRecordings()
    func openPermissionRequest(with model: PermissionRequest)
}

