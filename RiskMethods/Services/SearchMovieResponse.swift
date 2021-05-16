//
//  SearchMovieResponse.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import Foundation

struct SearchMovieResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }

    let movies: [Movie]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movies = try container.decode([Movie].self, forKey: .results)
    }
}
