//
//  SideMenuPresentAnimatorTests.swift
//  YSideMenu
//
//  Created by Caio Coan on 27/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YSideMenu

final class SideMenuPresentAnimatorTests: XCTestCase {
    func test_animate() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(menuViewController: menuController, to: menuController)

        XCTAssertTrue(sut is SideMenuPresentAnimator)
        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertTrue(context.didComplete)
    }

    func test_animateWithoutReduceMotion_SlideRight() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(
            menuViewController: menuController,
            to: menuController,
            isReduceMotionEnabled: false
        )

        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertEqual(menuController.dimmerView.alpha, 1)
        XCTAssertLessThan(menuController.contentView.frame.maxX, context.containerView.bounds.maxX)
    }

    func test_animateWithReduceMotion_FadesIn() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(
            menuViewController: menuController,
            to: menuController,
            isReduceMotionEnabled: true
        )

        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertEqual(menuController.dimmerView.alpha, 1)
        XCTAssertEqual(menuController.contentView.alpha, 1)
    }

    func test_animateWithoutTo_Fails() throws {
        let menuController = makeMenu()
        let (sut, context) = try makeSUT(menuViewController: menuController, to: nil)

        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertFalse(context.didComplete)
    }
}

private extension SideMenuPresentAnimatorTests {
    func makeSUT(
        menuViewController: SideMenuController,
        to: UIViewController?,
        isReduceMotionEnabled: Bool? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> (UIViewControllerAnimatedTransitioning, MockAnimationContext) {
        let main = UIViewController()
        let animator = try XCTUnwrap(
            menuViewController.animationController(
                forPresented: menuViewController,
                presenting: main,
                source: main
            ) as? SideMenuAnimator
        )
        animator.reduceMotionOverride = isReduceMotionEnabled
        let context = MockAnimationContext(from: main, to: to)
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
