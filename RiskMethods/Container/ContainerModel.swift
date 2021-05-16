//
// Created by jucham01 on 16/05/2021.
//

import Foundation
import Combine

class ContainerModel {
    private(set) lazy var searchModel: SearchModel = .init(networkService: serviceProvider.network)
    private(set) lazy var listModel: ListModel = .init(serviceProvider: serviceProvider)

    private let serviceProvider: ServiceProvider
    private var cancellable: AnyCancellable?

    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }

    func setup() {
        cancellable = searchModel.$movies.sink { [weak listModel] movies in
            listModel?.update(movies: movies)
        }
    }
}
