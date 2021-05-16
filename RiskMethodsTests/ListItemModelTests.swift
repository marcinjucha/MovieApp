//
// Created by jucham01 on 16/05/2021.
//

import XCTest
import Combine
@testable import RiskMethods

final class ListItemModelTests: XCTestCase {

    let networkService = NetworkServiceMock()
    let cacheService = CacheServiceMock()
    let movie = Movie.mock
    lazy var sut = ListItemModel(networkService: networkService, cacheService: cacheService, movie: movie)
    private var cancellable: AnyCancellable?

    func test_ToggleIsWatched_IsWatched_ShouldBeChangedToOpposite() {
        XCTAssertEqual(sut.isWatched, false)

        sut.toggleIsWatched()

        XCTAssertEqual(sut.isWatched, true)

        sut.toggleIsWatched()

        XCTAssertEqual(sut.isWatched, false)
    }

    func test_FetchImage_ShouldCall_NetworkFetchPoster_SaveDataToCache() {
        let data = Data()
        networkService.fetchPosterPublisher = justWithError(data)

        sut.fetchImage()

        invokeFetchPoster(data: data) { _ in
            self.validateCache(data: data)
            self.validatePosterFetcher()
        }
    }

    func test_FetchImage_ShouldNotCall_NetworkFetchPoster_WhenPosterIsCached() {
        let data = Data()
        networkService.fetchPosterPublisher = justWithError(data)
        cacheService.objectData = data as NSData

        sut.fetchImage()

        invokeFetchPoster(data: data) { _ in
            self.validatePosterFetcher(count: 0)
        }
    }

    private func invokeFetchPoster(data: Data, validation: @escaping (Data?) -> Void) {
        cancellable = sut.$imageData.dropFirst().sink(receiveValue: { d in
            XCTAssertEqual(d, data)
            validation(d)
        })
    }

    private func validatePosterFetcher(count: Int = 1) {
        XCTAssertEqual(networkService.fetchPosterCount, count)
        XCTAssertEqual(networkService.fetchPosterPath, movie.posterPath)
    }

    private func validateCache(data: Data, count: Int = 1) {
        XCTAssertEqual(cacheService.cacheCount, count)
        XCTAssertEqual(cacheService.cacheObject, data as NSData)
        XCTAssertEqual(cacheService.cacheKey, movie.posterPath! as NSString)
    }
}
