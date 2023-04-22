//
//  Animator.swift
//  Created by bemohansingh on 14/02/2022.

import Foundation
import UIKit

public protocol Animator: UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval { get set }
    var isPresenting: Bool { get set }
}

