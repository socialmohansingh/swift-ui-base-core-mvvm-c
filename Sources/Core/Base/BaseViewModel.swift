//  BaseViewModel.swift
//  Created by bemohansingh on 4/28/20.

import Foundation
import Combine

/// The baseViewModel for every viewModel
open class BaseViewModel {

    /// The subcription cleanup bag
    public var bag: Set<AnyCancellable>

    /// Routes trigger
    public var trigger: PassthroughSubject<AppRoutable, Never>
    
    /// The initializer
    public init() {
        self.bag = Set<AnyCancellable>()
        self.trigger = PassthroughSubject<AppRoutable, Never>()
    }
}
