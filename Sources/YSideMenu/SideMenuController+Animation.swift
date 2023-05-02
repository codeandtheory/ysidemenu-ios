//
//  SideMenuController+Animation.swift
//  YSideMenu
//
//  Created by Caio Coan on 27/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

extension SideMenuController: UIViewControllerTransitioningDelegate {
    /// Returns the animator for presenting a side menu
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        SideMenuPresentAnimator(sideMenuController: self)
    }
}
