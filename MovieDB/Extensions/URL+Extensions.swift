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
        case upcomingMovies
        case topRatedMovies
        
        case popularTVShows
        case onTheAirTVShows
        case topRatedTVShows
        
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
            case .upcomingMovies:
                components.path = "/3/movie/upcoming"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .topRatedMovies:
                components.path = "/3/movie/top_rated"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .popularTVShows:
                components.path = "/3/tv/popular"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .onTheAirTVShows:
                components.path = "/3/tv/on_the_air"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .topRatedTVShows:
                components.path = "/3/tv/top_rated"
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
    
    static var upcomingMovies: URL {
        Endpoint.upcomingMovies.url
    }
    
    static var topRatedMovies: URL {
        Endpoint.topRatedMovies.url
    }
    
    static var popularTVShows: URL {
        Endpoint.popularTVShows.url
    }
    
    static var onTheAirTVShows: URL {
        Endpoint.onTheAirTVShows.url
    }
    
    static var topRatedTVShows: URL {
        Endpoint.topRatedTVShows.url
    }
    
    static func forMoviesByName(_ name: String) -> URL {
        Endpoint.searchMovie(query: name).url
    }
}
