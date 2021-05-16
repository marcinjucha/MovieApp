//
// Created by jucham01 on 16/05/2021.
//

import Foundation
import Combine

protocol NetworkService {

    func fetchMovieList(for query: String) -> AnyPublisher<[Movie], Error>
    func fetchPoster(for path: String) -> AnyPublisher<Data, Error>
}

extension URLSessionDataTask: Cancellable {}

extension URLSession: NetworkService {
    private var apiKey: String { "808dd2ed8c88cdbf4bff0d58835ed07f" }
    private var searchURLPath: String { "https://api.themoviedb.org/3/search/movie" }

    func fetchMovieList(for query: String) -> AnyPublisher<[Movie], Error> {
        guard !query.isEmpty else {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }

        var components = URLComponents(string: searchURLPath)
        components?.queryItems = [
            .init(name: "api_key", value: apiKey), .init(name: "query", value: query)
        ]

        guard let url = components?.url else {
            preconditionFailure("Invalid url!")
        }

        return dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieList.self, decoder: JSONDecoder())
            .map(\.movies)
            .breakpointOnError()
            .eraseToAnyPublisher()
    }

    func fetchPoster(for path: String) -> AnyPublisher<Data, Error> {
        dataTaskPublisher(for: URL(string: "https://image.tmdb.org/t/p/w500\(path)")!)
            .map(\.data)
            .mapError { $0 }
            .breakpointOnError()
            .eraseToAnyPublisher()
    }
}

struct MovieList: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }

    let movies: [Movie]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movies = try container.decode([Movie].self, forKey: .results)
    }
}

struct Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case overview
        case id
    }

    let id: Int
    let title: String?
    let overview: String?
    let posterPath: String?
}
