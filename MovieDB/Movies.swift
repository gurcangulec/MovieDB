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
    var releaseDate: String?
    var backdropPath: String?
    var voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
    
    var formattedReleaseDate: String {
        // Unwrapping releaseDate
        if let releaseDate = releaseDate {
            // Formatting as a date
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            
            if let date = formatter.date(from: releaseDate) {
                let formatted = date.formatted(date: .abbreviated, time: .omitted)
                return formatted
            }
        }
        // If date is nil
        return "N/A"
    }
    
    var convertToString: String {
           return String(format: "%.1f", voteAverage)
    }
    
    static let example = Movie(id: 12, originalTitle: "Some Movie", overview: "An amazing title to be watched and remembered for the rest of our lives.", posterPath: "/huD4cMhHtLkxcdM6PbKBcivBZuE.jpg", releaseDate: "11-11-2022", backdropPath: "/huD4cMhHtLkxcdM6PbKBcivBZuE.jpg", voteAverage: 1.0)
}
