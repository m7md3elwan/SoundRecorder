//
//  RecordingsModuleFactory.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

class RecordingsModuleFactory {
    
    // MARK:- Methods
    static func makeModule() -> UIViewController? {
        if let viewController: RecordingsViewController = Storyboards.Main.instantiate() {
            let service = RecordingsService()
            let audioPlayer = AudioPlayer()
            viewController.viewModel = RecordingsViewModel(delegate: viewController,
                                                           service: service,
                                                           player: audioPlayer)
            return viewController
        }
        return nil
    }
}
