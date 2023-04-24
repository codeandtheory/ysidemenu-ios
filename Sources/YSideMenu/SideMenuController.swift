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
    private var menuWidth: CGFloat = Constants.defaultMenuWidth
    public let rootViewController: UIViewController!

    private enum Constants {
        static let defaultDimmerOpacity: CGFloat = 0.5
        static let animationDuration: CGFloat = 0.3
        static let defaultMenuWidth: CGFloat = 250
        static let maximumWidth: CGFloat = 414
        static var idealWidthPercentage: CGFloat = 0.8
    }

    // :nodoc:
    internal required init?(coder: NSCoder) { nil }

    public required init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        setupPresentation()
        self.rootViewController = rootViewController
        addChild(rootViewController)
    }

    private func setupPresentation() {
        // Modal configuration
        modalPresentationStyle = .overFullScreen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    private func configureLayout() {
        // Add views to view hierarchy
        view.addSubview(dimmerView)
        view.addSubview(contentView)
        dimmerView.constrainEdges()
        contentView.constrainEdges(.notTrailing)
        contentView.backgroundColor = .systemBackground

        // Add rootViewController
        contentView.addSubview(rootViewController.view)
        rootViewController.view.constrainEdges()
        rootViewController.didMove(toParent: self)

        // Setup dimmer view
        dimmerView.backgroundColor = UIColor.black
        dimmerView.alpha = Constants.defaultDimmerOpacity
        dimmerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimView)))

        contentView.constrain(
            .widthAnchor,
                                                    to: view.widthAnchor,
                                                    multiplier: Constants.idealWidthPercentage,
                                                    priority: .defaultHigh
        )
        contentView.constrain(.widthAnchor, constant: Constants.maximumWidth)

        // Position content view off-screen
        contentView.frame.origin.x = -menuWidth
    }

    @objc private func didTapDimView() {
        close()
    }

    @objc private func didTapCloseButton() {
        close()
    }

    // MARK: - Public Methods

    public func present() {
        rootViewController.present(
            self,
                                   animated: false
        ) {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.dimmerView.alpha = Constants.defaultDimmerOpacity
                self.contentView.frame.origin.x = .zero
            }
        }
    }

    public func close() {
        UIView.animate(
            withDuration: Constants.animationDuration,
                       animations: {
            self.dimmerView.alpha = .zero
            self.contentView.frame.origin.x = -self.menuWidth
        },
        completion: { [weak self] _ in
            self?.dismiss(animated: false)
        }
        )
    }

    public func setMenuWidth(_ width: CGFloat) {
        menuWidth = width
        contentView.frame.size.width = width
        contentView.frame.origin.x = -width
    }

    public func setBackgroundOpacity(_ opacity: CGFloat) {
        dimmerView.backgroundColor = UIColor.black.withAlphaComponent(opacity)
    }
}
