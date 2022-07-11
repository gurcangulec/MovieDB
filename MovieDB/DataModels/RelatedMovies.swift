//
//  RelatedMovies.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 09.07.2022.
//

import Foundation

struct RelatedMovies: Codable {
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results = "cast"
    }
}
