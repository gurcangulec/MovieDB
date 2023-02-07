//
//  FetchData.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.07.2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case noData
    case decodingError
}

enum HttpMethod {
    case get
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var headers: [String: String] = [:]
    var method: HttpMethod = .get
}

class HTTPClient {
    
    // Fetch data related to movies and tv shows
    func fetchData<T: Decodable>(of type: T.Type, _ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.headers
        request.httpMethod = resource.method.name
        
        switch resource.method {
        case .get:
            request.url = resource.url
        case .post(_ ):
            // Will come back later
            break
        default:
            break
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
    
    static func downloadPerson(personId: Int) async -> Actor {
            // Check URL
        guard let url = URL(string: "\(Constants.baseURL)person/\(personId)?api_key=\(Constants.APIKEY)&language=en-US") else {
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
        guard let url = URL(string: "\(Constants.baseURL)person/\(personId)/movie_credits?api_key=\(Constants.APIKEY)&language=en-US") else {
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
    
    static func downloadSpecificMovie(movieId: Int) async -> MovieDetails {
            // Check URL
            guard let url = URL(string: "\(Constants.baseURL)movie/\(movieId)?api_key=\(Constants.APIKEY)") else {
                print("Invalid URL")
                return MovieDetails(imdbId: "")
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(MovieDetails.self, from: data) {
                    return decoded
                }
            } catch {
                print("Invalid Something")
            }
        return MovieDetails(imdbId: "")
    }
    
    static func downloadSpecificTVShow(tvShowId: Int) async -> TVShowDetails {
            // Check URL
            guard let url = URL(string: "\(Constants.baseURL)tv/\(tvShowId)?api_key=\(Constants.APIKEY)") else {
                print("Invalid URL")
                return TVShowDetails(id: 0, createdBy: [], numberOfEpisodes: 0)
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(TVShowDetails.self, from: data) {
                    return decoded
                }
            } catch {
                print("Invalid Something")
            }
        return TVShowDetails(id: 0, createdBy: [], numberOfEpisodes: 0)
    }
    
}
