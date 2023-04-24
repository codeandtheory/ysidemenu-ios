//
//  SideMenuControllerTests.swift
//  YSideMenu
//
//  Created by Dev Karan on 14/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YSideMenu

final class SideMenuControllerTests: XCTestCase {
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    func test_initWithCoder() throws {
        let sut = SideMenuController(coder: try makeCoder(for: UIView()))
        XCTAssertNil(sut)
    }

    func testSideMenuViewReference() throws {
        let viewController = UIViewController()
        let menu = SideMenuController(rootViewController: viewController)

        XCTAssertTrue(menu.children.contains(viewController))
    }

    func makeCoder(for view: UIView) throws -> NSCoder {
        let data = try NSKeyedArchiver.archivedData(withRootObject: view, requiringSecureCoding: false)
        return try NSKeyedUnarchiver(forReadingFrom: data)
    }
}
