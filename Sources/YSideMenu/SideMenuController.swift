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

    private var idealWidthAnchor: NSLayoutConstraint?
    private var maximumWidthAnchor: NSLayoutConstraint?

    private enum Constants {
        static let defaultDimmerOpacity: CGFloat = 0.5
        static let maximumWidth: CGFloat = 414
        static var idealWidthPercentage: CGFloat = 0.8
    }

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

    @objc
    private func didTapDimmerView() {
        didDismiss()
    }

    internal func didDismiss() {
        dismiss(animated: true)
    }
}

private extension SideMenuController {
    func setupPresentation() {
        // Modal configuration
        modalPresentationStyle = .overFullScreen
    }

    func build() {
        buildViews()
        buildConstraints()
        configureViews()
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
        idealWidthAnchor = contentView.constrain(
            .widthAnchor,
            to: view.widthAnchor,
            multiplier: Constants.idealWidthPercentage,
            priority: .defaultHigh
        )

        maximumWidthAnchor = contentView.constrain(
            .widthAnchor,
            relatedBy: .lessThanOrEqual,
            constant: Constants.maximumWidth
        )
    }

    func configureViews() {
        dimmerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmerView)))
        contentView.backgroundColor = .systemBackground
        dimmerView.backgroundColor = UIColor.black
        dimmerView.alpha = Constants.defaultDimmerOpacity
    }
}

// Methods for unit testing
internal extension SideMenuController {
    @objc
    func simulateOnDimmerTap() {
        didTapDimmerView()
    }
}
