//
//  SideMenuController.swift
//  YSideMenu
//
//  Created by Caio Coan on 14/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YCoreUI

/// A view controller  that presents itself as a side menu (AKA hamburger menu)
public class SideMenuController: UIViewController {
    internal let contentView: UIView = UIView()
    internal var dimmerView: UIView = UIView()
    /// The child view controller to be displayed as a side menu
    public let rootViewController: UIViewController
    /// Side menu appearance
    public var appearance: Appearance = Appearance.default {
        didSet {
            updateAppearance()
        }
    }
    private var idealWidthAnchor: NSLayoutConstraint?
    private var maximumWidthAnchor: NSLayoutConstraint?
    /// Dimmer tap view
    let dimmerTapView: UIView = {
        let view = UIView()
        view.accessibilityTraits = .button
        view.accessibilityLabel = Strings.dimmerAccessibilityLabel.localized
        view.accessibilityIdentifier = AccessibilityIdentifiers.dimmerId
        return view
    }()

    /// :nodoc:
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not available for SideMenuController")
    }

    /// Initializes a side menu controller
    /// - Parameter rootViewController: child view controller to be displayed as a side menu
    public required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
        setupPresentation()
    }

    /// :nodoc:
    public override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    /// Performing the accessibility escape gesture dismisses the side menu.
    public override func accessibilityPerformEscape() -> Bool {
        didDismiss()
        return true
    }

    @objc
    private func didTapDimmerView() {
        didDismiss()
    }

    @objc
    private func didSwipeToDismiss() {
        didDismiss()
    }

    internal func didDismiss() {
        guard appearance.isDismissAllowed else { return }
        dismiss(animated: true)
    }
}

private extension SideMenuController {
    func setupPresentation() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    func build() {
        buildViews()
        buildConstraints()
        configureViews()
        configureAccessibility()
    }

    func updateAppearance() {
        dimmerTapView.isAccessibilityElement = appearance.isDismissAllowed
        dimmerView.backgroundColor = appearance.dimmerColor
        idealWidthAnchor?.isActive = false
        idealWidthAnchor = contentView.constrain(
            .widthAnchor,
            to: view.widthAnchor,
            multiplier: appearance.idealWidthPercentage,
            priority: .defaultHigh
        )
        maximumWidthAnchor?.isActive = false
        maximumWidthAnchor = contentView.constrain(
            .widthAnchor,
            relatedBy: .lessThanOrEqual,
            constant: appearance.maximumWidth
        )
    }

    func buildViews() {
        view.addSubview(dimmerView)
        view.addSubview(dimmerTapView)
        view.addSubview(contentView)
        
        addChild(rootViewController)
        contentView.addSubview(rootViewController.view)
        rootViewController.didMove(toParent: self)
    }

    func buildConstraints() {
        dimmerView.constrainEdges()
        dimmerTapView.constrainEdges(.notLeading)
        dimmerTapView.constrain(.leadingAnchor, to: contentView.trailingAnchor)
        rootViewController.view.constrainEdges()
        contentView.constrainEdges(.notTrailing)
    }

    func configureViews() {
        dimmerTapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmerView)))
        updateAppearance()

        contentView.backgroundColor = .systemBackground
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeToDismiss))
        swipeGesture.direction = .left
        contentView.addGestureRecognizer(swipeGesture)
    }

    func configureAccessibility() {
        accessibilityElements = [contentView, dimmerView]
    }
}

// Methods for unit testing
internal extension SideMenuController {
    @objc
    func simulateOnDimmerTap() {
        didTapDimmerView()
    }

    @objc
    func simulateSwipeToDismiss() {
        didSwipeToDismiss()
    }
}
