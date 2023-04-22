//
//  KeychainCache.swift
//  BMApp
//
//  Created by bemohansingh on 04/12/2021.
//  Copyright © 2021 bemohansingh. All rights reserved.
//

import Foundation
import KeychainAccess

struct KeychainCache: Cacheable {
    
    private let keychain = Keychain(service: "com.ebpearls.service")
    
    func set(value: Data, key: CacheKeyable) {
        keychain[data: key.key] = value
    }
    
    func getData(key: CacheKeyable) -> Data? {
        keychain[data: key.key]
    }
    
    func set(value: String, key: CacheKeyable) {
        keychain[string: key.key] = value
    }
    
    func getString(key: CacheKeyable) -> String? {
        keychain[string: key.key]
    }
    
    func remove(key: CacheKeyable) throws {
        try keychain.remove(key.key)
    }
}
