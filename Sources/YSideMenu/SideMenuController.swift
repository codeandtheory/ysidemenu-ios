//
//  SideMenuController.swift
//  YSideMenu
//
//  Created by Dev Karan on 14/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YCoreUI

/// A view controller  that represents a `SideMenu`.
public class SideMenuController: UIViewController {
    private let contentView: UIView = UIView()
    private var dimmerView: UIView = UIView()
    public let rootViewController: UIViewController!
    private var idealWidthAnchor: NSLayoutConstraint?
    private var maximumWidthAnchor: NSLayoutConstraint?

    private enum Constants {
        static let defaultDimmerOpacity: CGFloat = 0.5
        static let animationDuration: CGFloat = 0.3
        static let maximumWidth: CGFloat = 414
        static var idealWidthPercentage: CGFloat = 0.8
    }

    // :nodoc:
    internal required init?(coder: NSCoder) { nil }

    public required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
        setupPresentation()
        addChild(rootViewController)
    }

    private func setupPresentation() {
        // Modal configuration
        modalPresentationStyle = .overFullScreen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    @objc
    private func didTapDimmerView() {
        close()
    }

    @objc
    private func didTapCloseButton() {
        close()
    }

    private func close() {
        dismiss(animated: true)
    }
}

private extension SideMenuController {
    private func build() {
        buildViews()
    }

    private func buildViews() {
        view.addSubview(dimmerView)
        view.addSubview(contentView)
        contentView.addSubview(rootViewController.view)
        rootViewController.didMove(toParent: self)
    }

    private func buildConstraints() {
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

    private func configureViews() {
        dimmerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmerView)))
        contentView.backgroundColor = .systemBackground
        dimmerView.backgroundColor = UIColor.black
        dimmerView.alpha = Constants.defaultDimmerOpacity
    }
}
