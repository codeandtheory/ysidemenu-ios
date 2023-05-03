//
//  Animation+SideMenu.swift
//  YSideMenu
//
//  Created by Mark Pospesel on 5/3/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import YCoreUI

/// Default animation properties for snackbar operations
public extension Animation {
    /// Default animation for presenting a side menu
    static let defaultPresent = Animation(curve: .regular(options: .curveEaseIn))

    /// Default animation for dismissing a side menu
    static let defaultDismiss = Animation(curve: .regular(options: .curveEaseOut))
}
