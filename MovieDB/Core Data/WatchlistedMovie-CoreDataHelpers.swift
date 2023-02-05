//
//  WatchlistedMovie-CoreDataHelpers.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 05.02.2023.
//

import Foundation

extension WatchlistedMovieEntity {
    
    var wMovieTitle: String {
        title ?? ""
    }
    
    var wMmovieRating: String {
        String(format: "%.1f", rating)
    }
    
    var wMmovieOverview: String {
        overview ?? ""
    }
    
    var wMmovieDateAdded: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: dateAdded ?? Date.now)
    }
    
    var wMmovieReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: releaseDate ?? Date.now)
    }
    
    var wMmovieBackdropPath: String {
        backdropPath ?? ""
    }
    
    var wMmoviePosterPath: String {
        posterPath ?? ""
    }
}
