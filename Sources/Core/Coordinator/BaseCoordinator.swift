//  BaseCoordinator.swift
//  Created by bemohansingh on 12/18/19.

import UIKit

// The base coordinator
open class BaseCoordinator: Coordinator {
    
    // Private property to hold refrence to child coordinators
    private(set) var childCoordinators: [Coordinator] = []
    
    // When a coordinator is removed
    private var onRemove: (() -> Void)?
    
    // When a coordinator is finished
    public var onFinish: (() -> Void)?
    
    // Public initializer
    public init() {}
    
    /// Method to start the coordinator with deeplink
    ///
    /// - Parameter deepLink: the deepLink
    open func start(with deepLink: DeepLink? = nil) {}
    
    /// This method will add the child coordinator that are currently coordinating
    ///
    /// - Parameter coordinator: the coordinator
    private func addChild(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator}) else { return } //child coordinator is already coordinating check
        childCoordinators.append(coordinator)
    }
    
    /// Method to remove child coordinator. This method will remove all the child coordinators of the provided coordinator as well
    ///
    /// - Parameter coordinator: the coordinator to remove
    private func removeChild(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty, let coordinator = coordinator as? BaseCoordinator else { return }
        // Remove all childs of coordinator
        if !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeChild($0) })
        }
        
        // Remove the coordinator itself
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    /// This method will add new coordinator and start it
    ///
    /// - Parameter coordinator: the coordinator to start
    @discardableResult
    public func coordinate<T: BaseCoordinator>(_ type: T.Type = T.self, to coordinator: T, deepLink: DeepLink? = nil) -> BaseCoordinator {
        if deepLink != nil, let requiredCoordinator = getChild(type: T.self) {
            requiredCoordinator.start(with: deepLink)
            return requiredCoordinator
        } else {
            addChild(coordinator)
            coordinator.onRemove = { [unowned self, unowned coordinator] in
                self.removeChild(coordinator)
            }
            coordinator.start(with: deepLink)
            return coordinator
        }
    }
    
    /// Method to complete the opertaion of a coordinator
    public func finish() {
        onRemove?()
        onFinish?()
    }
    
    /// returns child coordinator of type C if it exists. else return nil
    /// - Parameter type: class of type Coordinator
    private func getChild<C>(type: C.Type) -> C? {
        for coordinator in childCoordinators {
            if let requiredCoordinator = coordinator as? C {
                return requiredCoordinator
            }
        }
        return nil
    }
    
    /// Just removes the child coordinators 
    public func removeAllChild() {
        childCoordinators.removeAll()
    }
}
