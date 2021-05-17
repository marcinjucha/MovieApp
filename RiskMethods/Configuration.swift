//
//  Configuration.swift
//  RiskMethods
//
//  Created by jucham01 on 17/05/2021.
//

import Foundation

struct Configuration: Codable {

    let apiKey: String

    static let `default`: Configuration = {
        let decoder = PropertyListDecoder()
        guard let url = Bundle.main.url(forResource: "Configuration", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let configuration = try? decoder.decode(Configuration.self, from: data) else {
            preconditionFailure("Cannot fail!")
        }

        return configuration
    }()

}
