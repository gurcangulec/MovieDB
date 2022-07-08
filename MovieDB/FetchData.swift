//
//  FetchData.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.07.2022.
//

import Foundation

struct FetchData {
    @available(*, unavailable) private init() {}

    static func downloadMovies(searchQuery: String) async -> [Movie] {
            let replaced = searchQuery.replacingOccurrences(of: " ", with: "+").lowercased()
            // Check URL
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=c74260965badd03144f9a327f254f0a2&query=\(replaced)") else {
                print("Invalid URL")
                return []
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(Movies.self, from: data) {
                    return decoded.results
                }
            } catch {
                print("Invalid Something")
            }
        return []
    }
    
    static func downloadPopularMovies() async-> [Movie] {
            // Check URL
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=c74260965badd03144f9a327f254f0a2&language=en-US&page=1") else {
                print("Invalid URL")
                return []
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(Movies.self, from: data) {
                    return decoded.results
                }
            } catch {
                print("Invalid Something")
            }
        return []
    }
    
    static func downloadCast(movieId: Int) async -> [CastMember] {
            // Check URL
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=c74260965badd03144f9a327f254f0a2&language=en-US") else {
                print("Invalid URL")
                return []
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                // Decode from data
                if let decoded = try? decoder.decode(Cast.self, from: data) {
                    return decoded.results
                }
            } catch {
                print("Invalid Something")
            }
        return []
    }
}
