//  CoordinatorProtocol.swift
//  Created by bemohansingh on 9/11/20.

import UIKit

/// The presentable protocol for coordinators
public protocol Presentable {
    var presenting: UIViewController? { get }
}

/// The protocol for coordinator start
public protocol Coordinator: AnyObject {
    func start(with deepLink: DeepLink?)
}

/// The route protocol apply to only class
public protocol Route: AnyObject {
    associatedtype T
    init(rootController: T)
}
