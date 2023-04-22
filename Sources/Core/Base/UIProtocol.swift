//  UIProtocol.swift
//  Created by bemohansingh on 9/11/20.

import Foundation

/// The alert protocol
public protocol AlertActionable {
    var title: String { get }
    var destructive: Bool { get }
}

/// protocol for app route
public protocol AppRoutable {}
