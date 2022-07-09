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

//struct RelatedMovie: Codable, Identifiable {
//    var id: Int
//    var originalTitle: String
//    var character: String
//    var posterPath: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case originalTitle = "original_title"
//        case character = "character"
//        case posterPath = "poster_path"
//    }
//    
//    static let example = RelatedMovie(id: 100, originalTitle: "Green Book", character: "Cooper", posterPath: "/2mcg07areWJ4EAtDvafRz7eDVvb")
//}
