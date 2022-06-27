//
//  Movies.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 18.06.2022.
//

import Foundation

struct Movies: Codable {
    struct Movie: Codable, Identifiable {
        var id: Int
        var originalTitle: String
        var overview: String
        var posterPath: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case originalTitle = "original_title"
            case overview = "overview"
            case posterPath = "poster_path"
        }
    }
    
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}


