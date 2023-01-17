//
//  Movies.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 18.06.2022.
//

import Foundation

// Struct for results
struct Movies: Decodable {
    let results: [Movie]
}

// Struct for each movie
struct Movie: Decodable, Identifiable {
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let backdropPath: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
    
    var unwrappedPosterPath: String {
        posterPath ?? "Unknown"
    }
    
    var unwrappedBackdropPath: String {
        backdropPath ?? "Unknown"
    }
    
    var formattedReleaseDate: Date {
        if let releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.dateStyle = .medium
            print(dateFormatter.date(from: releaseDate) ?? Date.now)
            return dateFormatter.date(from: releaseDate) ?? Date.now
        }
        return Date.now
    }
    
    var convertToString: String {
           return String(format: "%.1f", voteAverage)
    }
    
    static let example = Movie(id: 12, originalTitle: "Some Movie", overview: "An amazing title to be watched and remembered for the rest of our lives.", posterPath: "/huD4cMhHtLkxcdM6PbKBcivBZuE.jpg", releaseDate: "11-11-2022", backdropPath: "/huD4cMhHtLkxcdM6PbKBcivBZuE.jpg", voteAverage: 1.0)
}
