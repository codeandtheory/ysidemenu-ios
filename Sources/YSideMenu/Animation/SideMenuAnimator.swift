//
//  SideMenuAnimator.swift
//  YSideMenu
//
//  Created by Caio Coan on 27/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Base class for side menu present and dismiss animators.
class SideMenuAnimator: NSObject {
    /// Side menu  controller.
    internal let sideMenuViewController: SideMenuController

    /// Override for isReduceMotionEnabled. Default is `nil`.
    ///
    /// For unit testing. When non-`nil` it will be returned instead of
    /// `UIAccessibility.isReduceMotionEnabled`,
    var reduceMotionOverride: Bool?

    /// Accessibility reduce motion is enabled or not.
    var isReduceMotionEnabled: Bool {
        reduceMotionOverride ?? UIAccessibility.isReduceMotionEnabled
    }

    /// Initializes a side menu animator.
    /// - Parameter sideMenuController: the menu being animated.
    init(sideMenuController: SideMenuController) {
        self.sideMenuViewController = sideMenuController
        super.init()
    }
}

extension SideMenuAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        sideMenuViewController.appearance.presentAnimation.duration
    }

    // Override this method and perform the animations
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(false)
    }
}
