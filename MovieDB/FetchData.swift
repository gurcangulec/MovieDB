//
//  FetchData.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.07.2022.
//

import Foundation

class FetchData {
    
    var movies: [Movie]

    @Sendable func downloadMovies(searchQuery: String) async {
            let replaced = searchQuery.replacingOccurrences(of: " ", with: "+").lowercased()
            // Check URL
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=c74260965badd03144f9a327f254f0a2&query=\(replaced)") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(Movies.self, from: data) {
                    movies = decoded.results
                }
            } catch {
                print("Invalid Something")
            }
    }
    
    init(movies: [Movie]) {
        self.movies = movies
    }
}
