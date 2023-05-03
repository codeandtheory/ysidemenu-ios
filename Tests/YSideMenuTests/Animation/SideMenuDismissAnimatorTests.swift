//
//  SideMenuDismissAnimatorTests.swift
//  YSideMenu
//
//  Created by Caio Coan on 27/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YSideMenu

final class SideMenuDismissAnimatorTests: XCTestCase {
    func test_animate() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(menuViewController: menuController, to: menuController)

        XCTAssertTrue(sut is SideMenuDismissAnimator)
        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertTrue(context.didComplete)
    }

    func test_animateWithoutReduceMotion_SlidesLeft() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(
            menuViewController: menuController,
            to: menuController,
            isReduceMotionEnabled: false
        )

        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertEqual(menuController.dimmerView.alpha, 0)
        XCTAssertEqual(menuController.contentView.alpha, 1)
        XCTAssertEqual(menuController.contentView.frame.maxX, 0)
    }

    func test_animateWithReduceMotion_FadesOut() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(
            menuViewController: menuController,
            to: menuController,
            isReduceMotionEnabled: true
        )

        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertEqual(menuController.dimmerView.alpha, 0)
        XCTAssertEqual(menuController.contentView.alpha, 0)
        XCTAssertEqual(menuController.contentView.frame.maxX, context.containerView.bounds.minX)
    }

    func test_animateWithoutFrom_Fails() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(
            menuViewController: menuController,
            presenting: nil,
            to: menuController
        )

        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertFalse(context.didComplete)
    }
}

private extension SideMenuDismissAnimatorTests {
    func makeSUT(
        menuViewController: SideMenuController,
        presenting: UIViewController? = UIViewController(),
        to: UIViewController?,
        isReduceMotionEnabled: Bool? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> (UIViewControllerAnimatedTransitioning, MockAnimationContext) {
        let animator = try XCTUnwrap(
            menuViewController.animationController(
                forDismissed: menuViewController
            ) as? SideMenuAnimator
        )
        animator.reduceMotionOverride = isReduceMotionEnabled
        let context = MockAnimationContext(from: presenting, to: to)
        trackForMemoryLeak(animator)
        trackForMemoryLeak(context)
        return (animator, context)
    }

    func makeMenu(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SideMenuController {
        let menu = SideMenuController(rootViewController: UIViewController())
        trackForMemoryLeak(menu)
        return menu
    }
}
