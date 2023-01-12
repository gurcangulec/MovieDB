//
//  FetchData.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.07.2022.
//

import Foundation

struct FetchData {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    static let APIKey = "c74260965badd03144f9a327f254f0a2"

    static func downloadMovies(searchQuery: String) async -> [Movie] {
            let replaced = searchQuery.replacingOccurrences(of: " ", with: "+").lowercased()
            // Check URL
            guard let url = URL(string: "\(baseURL)search/movie?api_key=\(APIKey)&query=\(replaced)") else {
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
            guard let url = URL(string: "\(baseURL)movie/popular?api_key=\(APIKey)&language=en-US&page=1") else {
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
        guard let url = URL(string: "\(baseURL)movie/\(movieId)/credits?api_key=\(APIKey)&language=en-US") else {
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
    
    static func downloadCrew(movieId: Int) async -> [CrewMember] {
            // Check URL
        guard let url = URL(string: "\(baseURL)movie/\(movieId)/credits?api_key=\(APIKey)&language=en-US") else {
                print("Invalid URL")
                return []
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                // Decode from data
                if let decoded = try? decoder.decode(Crew.self, from: data) {
                    return decoded.results
                }
            } catch {
                print("Invalid Something")
            }
        return []
    }
    
    static func downloadPerson(personId: Int) async -> Actor {
            // Check URL
        guard let url = URL(string: "\(baseURL)person/\(personId)?api_key=\(APIKey)&language=en-US") else {
                print("Invalid URL")
                return Actor.example
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                // Decode from data
                if let decoded = try? decoder.decode(Actor.self, from: data) {
                    return decoded
                }
            } catch {
                print("Invalid Something")
            }
        return Actor.example
    }
    
    static func downloadRelatedMovies(personId: Int) async -> [Movie] {
            // Check URL
        guard let url = URL(string: "\(baseURL)person/\(personId)/movie_credits?api_key=\(APIKey)&language=en-US") else {
                print("Invalid URL")
                return []
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                // Decode from data
                if let decoded = try? decoder.decode(RelatedMovies.self, from: data) {
                    return decoded.results
                }
            } catch {
                print("Invalid Something")
            }
        return []
    }
    
    static func downloadPopularTVShows() async-> [TVShow] {
            // Check URL
            guard let url = URL(string: "\(baseURL)tv/popular?api_key=\(APIKey)&language=en-US&page=1") else {
                print("Invalid URL")
                return []
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(TVShows.self, from: data) {
                    return decoded.results
                }
            } catch {
                print("Invalid Something")
            }
        return []
    }
    
    static func downloadTopRatedMovies() async-> [Movie] {
            // Check URL
            guard let url = URL(string: "\(baseURL)movie/top_rated?api_key=\(APIKey)&language=en-US&page=1") else {
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
    
    static func downloadUpcomingMovies() async-> [Movie] {
            // Check URL
            guard let url = URL(string: "\(baseURL)movie/upcoming?api_key=\(APIKey)&language=en-US&page=1") else {
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
    
    static func downloadTopRatedTVShows() async-> [TVShow] {
            // Check URL
            guard let url = URL(string: "\(baseURL)tv/top_rated?api_key=\(APIKey)&language=en-US&page=1") else {
                print("Invalid URL")
                return []
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(TVShows.self, from: data) {
                    return decoded.results
                }
            } catch {
                print("Invalid Something")
            }
        return []
    }
    
}
