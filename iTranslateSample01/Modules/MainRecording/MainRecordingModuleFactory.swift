//
//  MainRecordingModuleFactory.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/20/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import UIKit

class MainRecordingModuleFactory {
    
    // MARK:- Methods
    static func makeModule() -> UIViewController? {
        if let viewController: MainRecordingViewController = Storyboards.Main.instantiate() {
            let service = RecordingsService()
            let recorder = AudioRecorder()
            let router = MainRecordingRouter()
            let recordIndexService = RecordIndexService.shared
            router.viewController = viewController
            
            viewController.viewModel = MainRecordingViewModel(delegate: viewController,
                                                              service: service,
                                                              router: router,
                                                              recorder: recorder,
                                                              recordIndexService: recordIndexService)
            return viewController
        }
        return nil
    }
}
