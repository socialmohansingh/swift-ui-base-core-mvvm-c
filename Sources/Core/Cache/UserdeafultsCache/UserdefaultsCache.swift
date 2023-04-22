//
//  UserdefaultsCache.swift
//  BMApp
//
//  Created by bemohansingh on 04/12/2021.
//  Copyright © 2021 bemohansingh. All rights reserved.
//

import Foundation

struct UserdefaultCache: Cacheable {
    
    private let defaults = UserDefaults.self
    
    func set(value: Data, key: CacheKeyable) {
        defaults.standard.set(value, forKey: key.key)
    }
    
    func getData(key: CacheKeyable) -> Data? {
        defaults.standard.data(forKey: key.key)
    }
    
    func set(value: String, key: CacheKeyable) {
        defaults.standard.set(value, forKey: key.key)
    }
    
    func getString(key: CacheKeyable) -> String? {
        defaults.standard.string(forKey: key.key)
    }
    
    func remove(key: CacheKeyable) throws {
        defaults.standard.removeObject(forKey: key.key)
    }
}
