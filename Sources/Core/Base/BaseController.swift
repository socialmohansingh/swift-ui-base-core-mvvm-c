//  BaseController.swift
//  Created by bemohansingh on 4/28/20.

import UIKit
import Foundation
import Combine

/// The parent of all controller inside app
open class BaseController: UIViewController, StoryboardInitializable {
    
    /// The baseView of controller
    public private(set) var baseView: BaseView!
    
    /// The baseViewModel of controller
    public private(set) var baseViewModel: BaseViewModel!
    
    /// The flag to check if the controller was initialized from storyboard
    private let isStoryboardIntialized: Bool
    
    /// when view is loaded
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        /// setup UI
        setupUI()
        
        /// observe events
        observeEvents()
    }
    
    /// Method that will set the viewmodel after initialization from storyboard
    /// - Parameter viewModel: the viewmodel for the controller
    func setViewModel(viewModel: BaseViewModel) {
        guard baseViewModel == nil else { return }
        baseViewModel = viewModel
    }
    
    /// Initializer for a controller
    /// - Parameters:
    ///   - baseView: the view associated with the controller
    ///   - baseViewModel: viewModel associated with the controller
    public init(baseView: BaseView, baseViewModel: BaseViewModel) {
        self.baseView = baseView
        self.baseViewModel = baseViewModel
        self.isStoryboardIntialized = false
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Not available
    required public init?(coder: NSCoder) {
        self.isStoryboardIntialized = true
        super.init(coder: coder)
    }
    
    /// Load the base view as the view of controller
    override open func loadView() {
        super.loadView()
        guard !isStoryboardIntialized else { return }
        view = baseView
    }
    
    /// setup trigger
    open func setupUI() {}
    
    /// Observer for events
    open func observeEvents() {}
}

extension BaseController {
    
    /// Method to present alert with actions provided
    /// - Parameters:
    ///   - title: the title of alert
    ///   - msg: the message of alert
    ///   - actions: the actions to display
    open func alert(title: String, msg: String, actions: [AlertActionable]) -> AnyPublisher<AlertActionable, Never> {
        
        Future<AlertActionable, Never> { [weak self] promise in
            guard let self = self else { return }
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            actions.forEach { action in
                let alertAction = UIAlertAction(title: action.title, style: action.destructive ? .destructive: .default) { _ in
                    promise(.success(action))
                }
                alert.addAction(alertAction)
            }
            self.present(alert, animated: true, completion: nil)
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    /// Method to present alert with actions provided
    /// - Parameters:
    ///   - title: the attributed title of alert
    ///   - msg: the attributed message of alert
    ///   - actions: the actions to display
    open func alert(title: NSAttributedString, msg: NSAttributedString, actions: [AlertActionable]) -> AnyPublisher<AlertActionable, Never> {
        
        Future<AlertActionable, Never> { [weak self] promise in
            guard let self = self else { return }
            let alert = UIAlertController(title: title.string, message: msg.string, preferredStyle: .alert)
            alert.setValue(title, forKey: "attributedTitle")
            alert.setValue(msg, forKey: "attributedMessage")
            actions.forEach { action in
                let alertAction = UIAlertAction(title: action.title, style: action.destructive ? .destructive: .default) { _ in
                    promise(.success(action))
                }
                alert.addAction(alertAction)
            }
            self.present(alert, animated: true, completion: nil)
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
