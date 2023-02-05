//
//  RatedMovie-CoreDataHelpers.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 05.02.2023.
//

import Foundation

extension RatedMovieEntity {
    var rMovieTitle: String {
        title ?? ""
    }
    
    var rMmovieRating: String {
        String(format: "%.1f", rating)
    }
    
    var rMmovieOverview: String {
        overview ?? ""
    }
    
    var rMmovieDateAdded: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: dateAdded ?? Date.now)
    }
    
    var rMmovieReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: releaseDate ?? Date.now)
    }
    
    var rMmovieBackdropPath: String {
        backdropPath ?? ""
    }
    
    var rMmoviePosterPath: String {
        posterPath ?? ""
    }
}
