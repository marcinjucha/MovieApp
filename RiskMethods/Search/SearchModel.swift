//
// Created by jucham01 on 16/05/2021.
//

import Foundation
import Combine

class SearchModel {

    @Published private(set) var movies: [Movie] = []
    @Published private var query: String = ""

    private let networkService: NetworkService
    private var cancellable: AnyCancellable?

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func setup() {
        cancellable = $query
            .dropFirst()
            .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .flatMap { [weak self] in
                self?.networkService.fetchMovieList(for: $0)
                    ?? justWithError([])
            }
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(error) = completion else { return }
                    print(error)
                },
                receiveValue: { [weak self] movies in
                    self?.movies = movies
                }
            )
    }

    func search(for query: String) {
        self.query = query
    }

}