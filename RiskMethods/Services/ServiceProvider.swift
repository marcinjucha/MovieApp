//
// Created by jucham01 on 16/05/2021.
//

import UIKit

struct ServiceProvider {
    let network: NetworkService
    let system: SystemService
    let cache: CacheService

    init(network: NetworkService = URLSession.shared,
         system: SystemService = UIApplication.shared,
         cache: CacheService = ImageCacheService()) {
        self.network = network
        self.system = system
        self.cache = cache
    }
}