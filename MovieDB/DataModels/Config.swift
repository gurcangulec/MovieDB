//
//  Config.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 30.07.2022.
//

import Foundation

struct Config {
    var baseURL: String?
    var secureBaseURL: String?
    var backdropSizes: [String]?
    var logoSizes: [String]?
    var posterSizes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
    }
}
