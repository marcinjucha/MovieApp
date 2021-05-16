//
// Created by jucham01 on 16/05/2021.
//

import Foundation

protocol CacheService {
    func cache(object: NSData, forKey key: NSString)
    func object(forKey key: NSString) -> NSData?
}


class ImageCacheService: CacheService {

    static let shared = ImageCacheService()

    private var imageCache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.totalCostLimit = 50_000_000
        return cache
    }()

    func cache(object: NSData, forKey key: NSString) {
        imageCache.setObject(object, forKey: key, cost: object.count)
    }
    func object(forKey key: NSString) -> NSData? {
        imageCache.object(forKey: key)
    }
}
