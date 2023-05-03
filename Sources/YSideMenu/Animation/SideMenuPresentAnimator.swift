//
//  SideMenuPresentAnimator.swift
//  YSideMenu
//
//  Created by Caio Coan on 27/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Performs the side menu  present animation.
class SideMenuPresentAnimator: SideMenuAnimator {
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        sideMenuViewController.appearance.presentAnimation.duration
    }

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        let menu = sideMenuViewController
        transitionContext.containerView.addSubview(toViewController.view)
        menu.view.layoutSubviews()
        menu.dimmerView.alpha = 0

        if isReduceMotionEnabled {
            menu.view.alpha = 0
        } else {
            let toFinalFrame = transitionContext.finalFrame(for: toViewController)
            var menuFrame = menu.contentView.frame
            menuFrame.origin.x = -toFinalFrame.maxX
            menu.contentView.frame = menuFrame
            // lay out menu's subviews prior to first appearance
            menu.contentView.layoutIfNeeded()
            menu.view.setNeedsLayout()
        }

        let duration = transitionDuration(using: transitionContext)

        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: [.beginFromCurrentState, .curveEaseInOut]
        ) {
            menu.dimmerView.alpha = 1
        }

        UIView.animate(with: menu.appearance.presentAnimation) {
            if self.isReduceMotionEnabled {
                menu.view.alpha = 1
            } else {
                menu.view.layoutIfNeeded()
            }
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
