//
//  SideMenuController+AppearanceTests.swift
//  YSideMenu
//
//  Created by Caio Coan on 26/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YSideMenu

final class SideMenuControllerAppearanceTests: XCTestCase {
    func test_init_propertiesDefaultValue() {
        let sut = SideMenuController.Appearance.default
        XCTAssertEqual(sut.dimmerColor, .black.withAlphaComponent(0.5))
        XCTAssertEqual(sut.maximumWidth, 414)
        XCTAssertEqual(sut.idealWidthPercentage, 0.8)
    }
}
