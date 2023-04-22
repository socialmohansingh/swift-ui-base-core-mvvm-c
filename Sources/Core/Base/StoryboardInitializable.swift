//  StoryboardInitializable.swift
//  Created by bemohansingh on 20/07/2021.

import Foundation
import UIKit

//// 1. make storyboard conforms to this for identification
public protocol StoryboardIdentifiable {
    var identifier: String { get }
}

//// 2. protocol to conforms to the storyboard identifier
public protocol StoryboardInitializable {
     static var storyboardIdentifier: String { get }
}

//// 3. create extension and implement the initialization
 extension StoryboardInitializable where Self: BaseController {

    public static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    public static func initialize(from storyboard: StoryboardIdentifiable, viewModel: BaseViewModel) -> Self {
        let storyboard = UIStoryboard(name: storyboard.identifier, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
        controller.setViewModel(viewModel: viewModel)
        return controller
    }
}
