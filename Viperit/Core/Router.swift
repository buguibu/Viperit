//
//  Router.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

import UIKit

public protocol RouterProtocol {
    weak var proxyPresenter: Presenter? { get set }
    var proxyView: UserInterface? { get }

    func show(inWindow window: UIWindow?, embedInNavController: Bool, setupData: Any?, makeKeyAndVisible: Bool)
    func show(from: UIViewController, embedInNavController: Bool, setupData: Any?)
    func show(from containerView: UIViewController, insideView targetView: UIView, setupData: Any?)
}

open class Router: RouterProtocol {
    public weak var proxyPresenter: Presenter?
    public var proxyView: UserInterface? {
        return proxyPresenter!.proxyView
    }

    open func show(inWindow window: UIWindow?,
                   embedInNavController: Bool = false,
                   setupData: Any? = nil,
                   makeKeyAndVisible: Bool = true) {
        process(setupData: setupData)
        let view = embedInNavController ? embedInNavigationController() : proxyView
        window?.rootViewController = view
        if makeKeyAndVisible {
            window?.makeKeyAndVisible()
        }
    }

    open func show(from: UIViewController, embedInNavController: Bool = false, setupData: Any? = nil) {
        process(setupData: setupData)
        let view = embedInNavController ? embedInNavigationController() : proxyView
        from.show(view!, sender: nil)
    }

    public func show(from containerView: UIViewController, insideView targetView: UIView, setupData: Any? = nil) {
        process(setupData: setupData)
        addAsChildView(ofView: containerView, insideContainer: targetView)
    }

    required public init() { }
}

// MARK: - Process possible setup data
private extension Router {
    func process(setupData: Any?) {
        if let data = setupData {
            proxyPresenter?.setupView(data: data)
        }
    }
}

// MARK: - Embed view in navigation controller
public extension Router {
    private func getNavigationController() -> UINavigationController? {
        if let nav = proxyView?.navigationController {
            return nav
        } else if let parent = proxyView?.parent {
            if let parentNav = parent.navigationController {
                return parentNav
            }
        }
        return nil
    }

    func embedInNavigationController() -> UINavigationController {
        return getNavigationController() ?? UINavigationController(rootViewController: proxyView!)
    }
}

// MARK: - Embed view in a container view
public extension Router {
    func addAsChildView(ofView parentView: UIViewController, insideContainer containerView: UIView) {
        parentView.addChildViewController(proxyView!)
        containerView.addSubview((proxyView?.view)!)
        stretchToBounds(containerView, view: (proxyView?.view)!)
        proxyView?.didMove(toParentViewController: parentView)
    }

    private func stretchToBounds(_ holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
}
