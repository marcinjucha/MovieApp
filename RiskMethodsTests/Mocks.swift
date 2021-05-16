//
// Created by jucham01 on 16/05/2021.
//

import Foundation
import Combine
@testable import RiskMethods

class NetworkServiceMock: NetworkService {

    var query: String!
    var fetchMovieListCount = 0
    var fetchMovieListPublisher: AnyPublisher<[Movie], Error>!
    func fetchMovieList(for query: String) -> AnyPublisher<[Movie], Error> {
        self.query = query
        fetchMovieListCount += 1

        return fetchMovieListPublisher
    }

    var fetchPosterPath: String!
    var fetchPosterCount = 0
    var fetchPosterPublisher: AnyPublisher<Data, Error>!
    func fetchPoster(for path: String) -> AnyPublisher<Data, Error> {
        fetchPosterPath = path
        fetchPosterCount += 1

        return fetchPosterPublisher
    }
}

class SystemServiceMock: SystemService {

    var id: Int!
    var openMovieCount: Int = 0
    func openMovie(withId id: Int) {
        openMovieCount += 1
        self.id = id
    }
}

class CacheServiceMock: CacheService {

    var cacheObject: NSData!
    var cacheKey: NSString!
    var cacheCount = 0
    func cache(object: NSData, forKey key: NSString) {
        cacheCount += 1
        cacheObject = object
        cacheKey = key
    }

    var objectCount = 0
    var objectKey: NSString!
    var objectData: NSData? = nil
    func object(forKey key: NSString) -> NSData? {
        objectCount += 1
        objectKey = key
        return objectData
    }
}

extension Movie {
    static let mock = Movie(id: 1234, title: "Movie", overview: "Overview", posterPath: "/poster-path")
}