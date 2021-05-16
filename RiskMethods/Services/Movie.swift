//
//  Movie.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import Foundation

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
