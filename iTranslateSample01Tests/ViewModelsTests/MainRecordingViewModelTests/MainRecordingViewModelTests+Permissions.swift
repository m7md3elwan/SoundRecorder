//
//  MainRecordingViewModelTests+Permissions.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation
import XCTest

@testable import iTranslateSample01

// MARK:- Permissions Switch Tests
extension MainRecordingViewModelTests {
    
    func permissionsTestCommonSetup() {
        mockRouter.mockCalls.openPermissionRequest = {
            self.goToPermissionCalled = true
        }
        
        mockAudioRecorder.mockCalls.startRecording = {
            self.startRecordingCalled = true
        }
        
        mockDelegate.mockCalls.errorOccured = { (error) in
            self.permissionError = error
        }
    }
    
    func test_permissions_undetermined() {
        mockRecordPermissionStatable.mockResponses.recordPermission = .undetermined
        permissionsTestCommonSetup()
        viewModel.recordButtonClicked()
        
        XCTAssertTrue(goToPermissionCalled)
        XCTAssertFalse(startRecordingCalled)
        XCTAssertNil(permissionError)
    }
    
    func test_permissions_granted() {
        mockRecordPermissionStatable.mockResponses.recordPermission = .granted
        permissionsTestCommonSetup()
        viewModel.recordButtonClicked()
        
        XCTAssertFalse(goToPermissionCalled)
        XCTAssertTrue(startRecordingCalled)
        XCTAssertNil(permissionError)
    }
    
    func test_permissions_denied() {
        mockRecordPermissionStatable.mockResponses.recordPermission = .denied
        permissionsTestCommonSetup()
        viewModel.recordButtonClicked()
        
        XCTAssertFalse(goToPermissionCalled)
        XCTAssertFalse(startRecordingCalled)
        XCTAssertNotNil(permissionError)
    }
}
