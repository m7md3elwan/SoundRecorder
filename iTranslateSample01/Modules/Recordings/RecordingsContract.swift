//
//  RecordingsContract.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import UIKit

protocol RecordingsViewModelDelegate: class {
    func recordingsUpdated()
    func showAudioPlayer(viewModel: RecordViewModel)
    func playingStateUpdated(currentTime: String, duration: String, percentage: Double)
    func hideAudioPlayer()
}

protocol RecordingsViewModelType {
    func viewLoaded()
    func numbetOfRecordings() -> Int
    func recordViewModelAt(index: Int) -> RecordViewModel?
    func editActionsForItemAt(index: Int) -> [EditActionViewModel]
    func userDidSelectItem(at index: Int)

}

