
import Foundation
import Combine

class ListItemModel {

    private static var imageCache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        cache.totalCostLimit = 50_000_000
        return cache
    }()

    @Published var imageData: Data? = nil
    let movie: Movie

    private let networkService: NetworkService
    private var cancellable: AnyCancellable?

    init(networkService: NetworkService, movie: Movie) {
        self.networkService = networkService
        self.movie = movie
    }

    func fetchImage() {
        guard let posterPath = movie.posterPath else { return }

        if let data = Self.imageCache.object(forKey: posterPath as NSString) {
            imageData = data as Data
        }

        cancellable = networkService.fetchPoster(for: posterPath)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            }, receiveValue: { [weak self] data in
                Self.imageCache.setObject(data as NSData, forKey: posterPath as NSString)
                self?.imageData = data
            })
    }
}