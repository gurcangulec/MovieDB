//
//  MovieDetails.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import CodableX
import Foundation

struct MovieDetails: Decodable {
    
    @Nullable var imdbId: String?

    enum CodingKeys: String, CodingKey {
        case imdbId = "imdb_id"
    }
    
    var unwrappedImdbId: String {
        imdbId ?? "Unknown"
    }
}
