//
//  MainRecordingViewModelTests.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import XCTest

@testable import iTranslateSample01

class MainRecordingViewModelTests: XCTestCase {
    
    // MARK:- Properties
    var viewModel: MainRecordingViewModel!
    
    // MARK:- Mocks
    var mockRecordsService: MockRecordingsService!
    var mockRecordIndex: MockRecordIndexService!
    var mockRecordPermissionStatable: MockRecordPermissionStatable!
    var mockAudioRecorder: MockAudioRecorder!
    var mockRouter: MockMainRecordingRouter!
    var mockDelegate: MockMainRecordingViewModelDelegate!
    
    // MARK:- Methods Spy
    var goToPermissionCalled = false
    var goToRecordingsCalled = false
    var startRecordingCalled = false
    var permissionError: Error? = nil
    
    // MARK:- Setup
    override func setUp() {
        mockDelegate = MockMainRecordingViewModelDelegate()
        mockRecordsService = MockRecordingsService()
        mockRecordIndex = MockRecordIndexService()
        mockRecordPermissionStatable = MockRecordPermissionStatable()
        mockAudioRecorder = MockAudioRecorder()
        mockRouter = MockMainRecordingRouter()
        viewModel = MainRecordingViewModel(delegate: mockDelegate,
                                           service: mockRecordsService,
                                           router: mockRouter,
                                           recorder: mockAudioRecorder,
                                           recordIndexService: mockRecordIndex,
                                           recordPermissionStateProvider: mockRecordPermissionStatable)
        
    }
    
    // MARK:- Tear Down
    override func tearDown() {
        goToPermissionCalled = false
        goToRecordingsCalled = false
        startRecordingCalled = false
        permissionError = nil
    }
    
    // MARK:- General Tests
    func test_dequeueNewRecordName() {
        XCTAssertTrue(viewModel.dequeueNewRecordName(newIndex: 0) == "Recording 0.m4a")
        XCTAssertTrue(viewModel.dequeueNewRecordName(newIndex: 1) == "Recording 1.m4a")
        XCTAssertTrue(viewModel.dequeueNewRecordName(newIndex: 2) == "Recording 2.m4a")
    }
    
    func test_showRecordingsAction() {
        mockRouter.mockCalls.openAllRecordings = {
            self.goToRecordingsCalled = true
        }
        viewModel.showRecordingsButtonClicked()
        XCTAssertTrue(goToRecordingsCalled)
    }    
    
}
