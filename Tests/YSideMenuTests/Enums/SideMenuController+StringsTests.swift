//
//  SideMenuController+StringsTests.swift
//  YSideMenu
//
//  Created by Caio Coan on 03/05/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI
@testable import YSideMenu

final class SideMenuControllerStringsTests: XCTestCase {
    func testLoad() {
        SideMenuController.Strings.allCases.forEach {
            // Given a localized string constant
            let string = $0.localized
            // it should not be empty
            XCTAssertFalse(string.isEmpty)
            // and it should not equal its key
            XCTAssertNotEqual($0.rawValue, string)
        }
    }
}
