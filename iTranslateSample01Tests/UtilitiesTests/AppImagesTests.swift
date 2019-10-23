//
//  AppImagesTests.swift
//  iTranslateSample01Tests
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import XCTest

@testable import iTranslateSample01

class AppImagesTests: XCTestCase {

    func test_AppImages_Not_Null () {
        for image in ImageAsset.allCases {
            XCTAssertNotNil(UIImage(asset: image))
        }
    }

}
