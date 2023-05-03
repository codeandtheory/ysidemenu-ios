//
//  SideMenuController.swift
//  YSideMenu
//
//  Created by Caio Coan on 14/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YCoreUI

/// A view controller  that represents a `SideMenu`.
public class SideMenuController: UIViewController {
    internal let contentView: UIView = UIView()
    internal var dimmerView: UIView = UIView()
    /// The child view controller to be displayed as a side menu
    public let rootViewController: UIViewController
    public var appearance: Appearance = Appearance.default {
        didSet {
            updateAppearance()
        }
    }
    private var idealWidthAnchor: NSLayoutConstraint?
    private var maximumWidthAnchor: NSLayoutConstraint?

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
    }

    func updateAppearance() {
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
        view.addSubview(contentView)
        
        addChild(rootViewController)
        contentView.addSubview(rootViewController.view)
        rootViewController.didMove(toParent: self)
    }

    func buildConstraints() {
        dimmerView.constrainEdges()
        rootViewController.view.constrainEdges()
        contentView.constrainEdges(.notTrailing)
    }

    func configureViews() {
        dimmerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmerView)))
        updateAppearance()

        contentView.backgroundColor = .systemBackground
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeToDismiss))
        swipeGesture.direction = .left
        contentView.addGestureRecognizer(swipeGesture)
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
