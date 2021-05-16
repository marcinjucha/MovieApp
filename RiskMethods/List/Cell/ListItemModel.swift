
import Foundation
import Combine

class ListItemModel {

    @Published var imageData: Data? = nil
    @Published var isWatched = false
    let movie: Movie

    private let networkService: NetworkService
    private let cacheService: CacheService
    private var cancellable: AnyCancellable?

    init(networkService: NetworkService, cacheService: CacheService, movie: Movie) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.movie = movie
    }

    func toggleIsWatched() {
        isWatched.toggle()
    }

    func fetchImage() {
        guard let posterPath = movie.posterPath else { return }

        if let data = cacheService.object(forKey: posterPath as NSString) {
            imageData = data as Data
            return
        }

        cancellable = networkService.fetchPoster(for: posterPath)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            }, receiveValue: { [weak self] data in
                self?.cacheService.cache(object: data as NSData, forKey: posterPath as NSString)
                self?.imageData = data
            })
    }
}
