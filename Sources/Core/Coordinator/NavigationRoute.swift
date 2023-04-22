//  NavigationRoute.swift
//  Created by bemohansingh on 9/11/20.

import UIKit

public class NavigationRoute: NSObject, Route {
    
    /// The refrence to controller
    public private(set) var rootController: UINavigationController?
    
    /// The animator for transition
    private var transitionAnimator: Animator?
    
    /// The initializer for Route
    public typealias Controller = UINavigationController
    public required init(rootController: Controller) {
        self.rootController = rootController
        super.init()
        self.rootController?.delegate = self
    }
    
    /// clean when done
    deinit {
        self.rootController = nil
    }
}

// Helpers for routing
extension NavigationRoute {
    
    /// Sets the controller as the root of rootController if the rootcontroller is navigation controller
    ///
    /// - Parameters:
    ///   - presentable: the controller to be set as root view controller
    ///   - animated: is the transition animated
    ///   - hideBar: will the navigation bar be hidden
    public func setRoot(_ presentable: Presentable?, animated: Bool = false, hideBar: Bool = true) {
        
        guard let navigationController = rootController,
            let controller = presentable?.presenting else {
                assertionFailure("Please properly check that controller and navigation controller both are provided")
                return
        }
        navigationController.isNavigationBarHidden = hideBar
        if hideBar {
            navigationController.navigationBar.prefersLargeTitles = false
            navigationController.navigationItem.largeTitleDisplayMode = .never
        }
        navigationController.setViewControllers([controller], animated: animated)
    }
    
    /// Present a controller on the routes root controller
    /// - Parameter presentable: the presenting controller
    public func present(_ presentable: Presentable?, animator: Animator? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let navigationController = rootController,
            let controller = presentable?.presenting else {
                assertionFailure("Please properly check that controller and navigation controller both are provided")
                return
        }
        transitionAnimator = animator
        animator?.isPresenting = true
        controller.presentationController?.delegate = controller
        navigationController.present(controller, animated: animated, completion: completion)
    }
    
    
    /// Dismiss the presented route
    /// - Parameter animated: the transition should be animated or not
    public func dismiss(animated: Bool = true, animator: Animator? = nil, completion: (() -> Void)? = nil) {
        guard let navigationController = rootController else {
            assertionFailure("Please properly check that controller and navigation controller both are provided")
            return
        }
        transitionAnimator = animator
        animator?.isPresenting = false
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    /// Push the controller on navigation stack if the root of the route is navigation controller
    ///
    /// - Parameters:
    ///   - presentable: the controller to push
    ///   - animated: animated or not
    public func push(_ presentable: Presentable?, animator: Animator? = nil, animated: Bool = true) {
        guard let navigationController = rootController,
            let controller = presentable?.presenting else {
                assertionFailure("Please properly check that controller and navigation controller both are provided")
                return
        }
        transitionAnimator = animator
        animator?.isPresenting = true
        navigationController.pushViewController(controller, animated: animated)
    }
    
    /// The method to pop the controller from navigation stack, if the root of route is navigation controller
    ///
    /// - Parameter animated: animated or not
    public func pop(toRoot: Bool = false, animator: Animator? = nil, animated: Bool = true) {
        guard let navigationController = rootController else {
            assertionFailure("Please properly check that navigation controller is present as the root of router")
            return
        }
        transitionAnimator = animator
        animator?.isPresenting = false
        if toRoot {
            navigationController.popToRootViewController(animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }
}

extension NavigationRoute: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionAnimator
    }
}
