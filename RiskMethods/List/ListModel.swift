//
// Created by jucham01 on 16/05/2021.
//

import Foundation
import Combine

class ListModel {
    @Published private(set) var itemModels: [ListItemModel] = []

    private let serviceProvider: ServiceProvider

    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    func open(movie: Movie) {
        serviceProvider.system.openMovie(withId: movie.id)
    }

    func update(movies: [Movie]) {
        itemModels = movies.map {
            ListItemModel(networkService: serviceProvider.network,
                          cacheService: serviceProvider.cache,
                          movie: $0)
        }
    }
}
