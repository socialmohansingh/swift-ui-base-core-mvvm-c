//  BaseExtension.swift
//  Created by bemohansingh on 9/11/20.

import UIKit

// MARK: - Making UIviewController confirms to presentable
extension UIViewController: Presentable, UIAdaptivePresentationControllerDelegate {
    public var presenting: UIViewController? {
        return self
    }
}

// MARK: - Extract the class name
extension UIViewController {
    public var name: String {
        return String(describing: self)
    }
}
