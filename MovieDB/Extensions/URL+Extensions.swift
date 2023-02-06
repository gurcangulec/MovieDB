//
//  URL+Extensions.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 31.01.2023.
//

import Foundation

extension URL {
    
    enum Endpoint {
        case configuration
        case searchMovie(query: String)
        case popularMovies
        
        var url: URL {
            var components = URLComponents()
            components.host = "api.themoviedb.org"
            components.scheme = "https"
            switch self {
            case .configuration:
                components.path = "/3/configuration"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY)
                ]
            case .searchMovie(let query):
                components.path = "/3/search/movie"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "query", value: query)
                ]
            case .popularMovies:
                components.path = "/3/movie/popular"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            }
            return components.url!
        }
    }
    
    static var popularMovies: URL {
        Endpoint.popularMovies.url
    }
    
    static func forMoviesByName(_ name: String) -> URL {
        Endpoint.searchMovie(query: name).url
    }
}
