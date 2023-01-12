//
//  TVShows.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 12.01.2023.
//

import Foundation

struct TVShows: Decodable {
    let results: [TVShow]
}

struct TVShow: Decodable, Identifiable {
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let backdropPath: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "original_name"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
    
    var unwrappedPosterPath: String {
        posterPath ?? "Unknown"
    }
    
    var formattedReleaseDate: String {
        if let releaseDate = releaseDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            
            if let date = formatter.date(from: releaseDate) {
                let formatted = date.formatted(date: .abbreviated, time: .omitted)
                return formatted
            }
        }
        return "N/A"
    }
    
    var convertToString: String {
           return String(format: "%.1f", voteAverage)
    }
}
