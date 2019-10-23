//
//  RecordingsViewModelTests.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import XCTest

@testable import iTranslateSample01

class RecordingsViewModelTests: XCTestCase {

    // MARK:- Properties
    var viewModel: RecordingsViewModel!
    
    // MARK:- Mocks
    var mockRecordsService: MockRecordingsService!
    var mockAudioPlayer: MockAudioPlayer!
    
    override func setUp() {
        mockRecordsService = MockRecordingsService()
        mockAudioPlayer = MockAudioPlayer()
        viewModel = RecordingsViewModel(delegate: nil, service: mockRecordsService, player: mockAudioPlayer)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_numbetOfRecordings() {
        mockRecordsService.mockResponses.getAllRecordings = [URL(fileURLWithPath: "test"), URL(fileURLWithPath: "test2")]
        viewModel.viewLoaded()
        XCTAssertTrue(viewModel.numbetOfRecordings() == 2)
        
        mockRecordsService.mockResponses.getAllRecordings = [URL(fileURLWithPath: "test")]
        viewModel.viewLoaded()
        XCTAssertTrue(viewModel.numbetOfRecordings() == 1)
        
        mockRecordsService.mockResponses.getAllRecordings = [URL(fileURLWithPath: "test"), URL(fileURLWithPath: "test2"), URL(fileURLWithPath: "test3")]
        viewModel.viewLoaded()
        XCTAssertTrue(viewModel.numbetOfRecordings() == 3)
        
        mockRecordsService.mockResponses.getAllRecordings = []
        viewModel.viewLoaded()
        XCTAssertTrue(viewModel.numbetOfRecordings() == 0)
    }
    
    func test_recordViewModelAt() {
        mockRecordsService.mockResponses.getAllRecordings = [URL(fileURLWithPath: "test"), URL(fileURLWithPath: "test2"), URL(fileURLWithPath: "test3")]
        viewModel.viewLoaded()
        
        XCTAssertNil(viewModel.recordViewModelAt(index: -1))
        XCTAssertNil(viewModel.recordViewModelAt(index: 4))
        XCTAssertNotNil(viewModel.recordViewModelAt(index: 0))
        XCTAssertNotNil(viewModel.recordViewModelAt(index: 1))
        XCTAssertNotNil(viewModel.recordViewModelAt(index: 2))
    }
    
    func test_editActionsForItemAt() {
        mockRecordsService.mockResponses.getAllRecordings = [URL(fileURLWithPath: "test"), URL(fileURLWithPath: "test2"), URL(fileURLWithPath: "test3")]
        viewModel.viewLoaded()
        
        XCTAssertTrue(viewModel.editActionsForItemAt(index: -1).isEmpty)
        XCTAssertTrue(viewModel.editActionsForItemAt(index: 5).isEmpty)
        XCTAssertTrue(viewModel.editActionsForItemAt(index: 0).count == 1)
        XCTAssertTrue(viewModel.editActionsForItemAt(index: 1).count == 1)
        XCTAssertTrue(viewModel.editActionsForItemAt(index: 2).count == 1)
    }
    
    func test_() {
        var currentlyPlayingRecord: Record?
        
        mockRecordsService.mockResponses.getAllRecordings = [URL(fileURLWithPath: "test"), URL(fileURLWithPath: "test2"), URL(fileURLWithPath: "test3")]
        viewModel.viewLoaded()
        
        mockAudioPlayer.mockCalls.startPlaying = { (url) in
            currentlyPlayingRecord = url
        }
        
        mockAudioPlayer.mockCalls.finishPlaying = {
             currentlyPlayingRecord = nil
         }

        viewModel.userDidSelectItem(at: -1)
        XCTAssertNil(currentlyPlayingRecord)
        
        viewModel.userDidSelectItem(at: 0)
        XCTAssertNotNil(currentlyPlayingRecord)

        viewModel.userDidSelectItem(at: 5)
        XCTAssertNotNil(currentlyPlayingRecord) // Keep on playing last successful Record
    }

}
