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
    
    var formattedReleaseDateForStorage: Date {
        if let releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.dateStyle = .medium
            return dateFormatter.date(from: releaseDate) ?? Date.now
        }
        return Date.now
    }
    
    var formattedReleaseDateForViews: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return formattedReleaseDateForStorage.formatted(date: .abbreviated, time: .omitted)
    }
    
    var convertToString: String {
           return String(format: "%.1f", voteAverage)
    }
}
