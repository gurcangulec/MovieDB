//
//  Movies.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 18.06.2022.
//

import Foundation

// Struct for results
struct Movies: Codable {
    var results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

// Struct for each movie
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

    static let example = Movie(id: 12, originalTitle: "Some Movie", overview: "An amazing title to be watched and remembered for the rest of our lives.", posterPath: "/huD4cMhHtLkxcdM6PbKBcivBZuE.jpg")
}
