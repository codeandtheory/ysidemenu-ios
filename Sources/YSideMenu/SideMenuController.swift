//
//  SideMenuController.swift
//  YSideMenu
//
//  Created by Dev Karan on 14/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// A view controller  that represents a `SideMenu`.
public class SideMenuController: UIViewController {

    private var contentView: UIView!
    private var dimView: UIView!
    private var menuWidth: CGFloat = Constants.defaultMenuWidth
    private var closeButton: UIButton!
    private var rootViewController: UIViewController!

    private enum Constants {
        static let defaultDimOpacity: CGFloat = 0.3
        static let animationDuration: CGFloat = 0.3
        static let defaultCloseButtonImage: UIImage = UIImage(systemName: "xmark")!
        static let defaultCloseButtonMargin: CGFloat = 16
        static let defaultMenuWidth: CGFloat = 250
    }

    public convenience init(rootViewController: UIViewController) {
        self.init()
        setupPresentation()
        self.rootViewController = rootViewController
    }

    private func setupPresentation()
    {
        // Modal configuration
        modalPresentationStyle = .overFullScreen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    private func configureLayout() {
        // Create content view
        contentView = UIView(frame: CGRect(x: .zero, y: .zero, width: menuWidth, height: view.bounds.height))
        contentView.backgroundColor = .white

        // Create close button
        closeButton = UIButton(type: .system)
        closeButton.setImage(Constants.defaultCloseButtonImage, for: .normal)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        contentView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constants.defaultCloseButtonMargin).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.defaultCloseButtonMargin).isActive = true

        // Create dim view
        dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor.black
        dimView.alpha = Constants.defaultDimOpacity
        dimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimView)))

        // Add views to view hierarchy
        view.addSubview(dimView)
        view.addSubview(contentView)

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
        rootViewController.present(self, animated: false)
        {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.dimView.alpha = Constants.defaultDimOpacity
                self.contentView.frame.origin.x = .zero
            }
        }
    }

    public func close() {
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.dimView.alpha = .zero
            self.contentView.frame.origin.x = -self.menuWidth
        }, completion: { [weak self] _ in
            self?.dismiss(animated: false)
        })
    }

    public func setMenuWidth(_ width: CGFloat) {
        menuWidth = width
        contentView.frame.size.width = width
        contentView.frame.origin.x = -width
    }

    public func setBackgroundOpacity(_ opacity: CGFloat) {
        dimView.backgroundColor = UIColor.black.withAlphaComponent(opacity)
    }

    public func addMenuItem(_ item: UIView) {
        contentView.addSubview(item)
    }

}
