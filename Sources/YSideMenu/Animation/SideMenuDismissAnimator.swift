//
//  SideMenuDismissAnimator.swift
//  YSideMenu
//
//  Created by Caio Coan on 14/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Performs the side menu  dismiss  animation.
class SideMenuDismissAnimator: SideMenuAnimator {
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        sideMenuViewController.appearance.dismissAnimation.duration
    }

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }

        let menu = sideMenuViewController
        var menuFrame = menu.contentView.frame
        menuFrame.origin.x = -menuFrame.width

        let duration = transitionDuration(using: transitionContext)

        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: .beginFromCurrentState
        ) {
            menu.dimmerView.alpha = 0
        }

        UIView.animate(
            with: menu.appearance.dismissAnimation
        ) {
            if self.isReduceMotionEnabled {
                menu.contentView.alpha = 0
            } else {
                menu.contentView.frame = menuFrame
            }
        }
        completion: { _ in
            if !transitionContext.transitionWasCancelled {
                fromViewController.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
