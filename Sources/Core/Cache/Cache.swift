//
//  Cache.swift
//  BMApp
//
//  Created by bemohansingh on 04/12/2021.
//  Copyright © 2021 bemohansingh. All rights reserved.
//

import Foundation

public enum CacheType {
    case keychain, userdefault
}

/// The cache for the app
public struct Cache: Cacheable {
    
    // The cacheable
    private let cacheable: Cacheable
    
    public init(type: CacheType) {
        switch type {
        case .keychain:
            self.cacheable = KeychainCache()
        case .userdefault:
            self.cacheable = UserdefaultCache()
        }
    }
    
    public func set(value: String, key: CacheKeyable) {
        cacheable.set(value: value, key: key)
    }
    
    public func getString(key: CacheKeyable) -> String? {
        cacheable.getString(key: key)
    }
    
    public func set(value: Data, key: CacheKeyable) {
        cacheable.set(value: value, key: key)
    }
    
    public func getData(key: CacheKeyable) -> Data? {
        cacheable.getData(key: key)
    }
    
    public func remove(key: CacheKeyable) throws {
        try cacheable.remove(key: key)
    }
}
