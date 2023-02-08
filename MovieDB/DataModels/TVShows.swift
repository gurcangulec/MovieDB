//
//  TVShows.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 12.01.2023.
//

import Foundation

struct TVShows: Codable {
    let results: [TVShow]
}

struct TVShow: Codable, Identifiable {
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let backdropPath: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "name"
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

struct TVShowDetails: Codable {
    let id: Int
    let createdBy: [Creators]
    let numberOfEpisodes: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdBy = "created_by"
        case numberOfEpisodes = "number_of_episodes"
    }
}

struct Creators: Codable, Identifiable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
}

struct TVShowCredits: Codable {
    let cast: [TVShowCast]
}

struct TVShowCast: Codable {
    let id: Int
    let name: String
    let roles: [Role]
    
    struct Role: Codable {
        let character: String
        let episodeCount: Int
        
        private enum CodingKeys: String, CodingKey {
            case character
            case episodeCount = "episode_count"
        }
    }
}


