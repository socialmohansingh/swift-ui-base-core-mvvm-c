//  Cacheable.swift
//  Created by bemohansingh on 04/12/2021.

import Foundation

public protocol CacheKeyable {
    var key: String { get }
}

public protocol Cacheable {
    
    /// string caching
    func set(value: String, key: CacheKeyable)
    func getString(key: CacheKeyable) -> String?
    
    /// data caching
    func set(value: Data, key: CacheKeyable)
    func getData(key: CacheKeyable) -> Data?
    
    /// remove data from cache
    func remove(key: CacheKeyable) throws
}
