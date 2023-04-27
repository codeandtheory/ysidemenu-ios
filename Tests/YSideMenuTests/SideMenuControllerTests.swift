//
//  SideMenuControllerTests.swift
//  YSideMenu
//
//  Created by Caio Coan on 14/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YSideMenu

final class SideMenuControllerTests: XCTestCase {
    func test_init_createsChildController() throws {
        let viewController = UIViewController()
        let sut = makeSUT(rootViewController: viewController)
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.children.contains(viewController))
        XCTAssertEqual(viewController.parent, sut)
        XCTAssertTrue(sut.contentView.subviews.contains(viewController.view))
    }

    func test_dimmerTap_dismissesSideMenu() {
        let sut = makeSpy(rootViewController: UIViewController())
        sut.loadViewIfNeeded()

        XCTAssertFalse(sut.onDimmerTapped)
        XCTAssertFalse(sut.isDismissed)

        sut.simulateOnDimmerTap()

        XCTAssertTrue(sut.onDimmerTapped)
        XCTAssertTrue(sut.isDismissed)
    }

    func test_swipeMenu_dismissesSideMenu() {
        let sut = makeSpy(rootViewController: UIViewController())
        sut.loadViewIfNeeded()

        XCTAssertFalse(sut.onMenuSwiped)
        XCTAssertFalse(sut.isDismissed)

        sut.simulateSwipeToDismiss()

        XCTAssertTrue(sut.onMenuSwiped)
        XCTAssertTrue(sut.isDismissed)
    }
}

private extension SideMenuControllerTests {
    func makeSUT(
        rootViewController: UIViewController,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SideMenuController {
        let sut = SideMenuController(rootViewController: rootViewController)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }

    func makeSpy(
        rootViewController: UIViewController,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SpySideMenuController {
        let sut = SpySideMenuController(rootViewController: rootViewController)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
}

final class SpySideMenuController: SideMenuController {
    var isDismissed = false
    var onDimmerTapped = false
    var onMenuSwiped = false

    override func didDismiss() {
        super.didDismiss()
        isDismissed = true
    }

    override func simulateOnDimmerTap() {
        super.simulateOnDimmerTap()
        onDimmerTapped = true
    }

    override func simulateSwipeToDismiss() {
        super.simulateSwipeToDismiss()
        onMenuSwiped = true
    }
}
