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
        case searchTVShow(query: String)
        
        case movieCrew(movieId: Int)
        case tvShowCrew(tvShowId: Int)
        
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
            case .searchTVShow(let query):
                components.path = "/3/search/tv"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "query", value: query)
                ]
            case .movieCrew(let movieId):
                components.path = "/3/movie/\(movieId)/credits"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY)
//                    URLQueryItem(name: "query", value: query)
                ]
            case .tvShowCrew(let tvShowId):
                components.path = "/3/tv/\(tvShowId)/credits"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY)
//                    URLQueryItem(name: "query", value: query)
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
    
    static func forMovieCastAndCrew(movieId: Int) -> URL {
        Endpoint.movieCrew(movieId: movieId).url
    }
    
    static func forTVShowCrew(tvShowId: Int) -> URL {
        Endpoint.tvShowCrew(tvShowId: tvShowId).url
    }
    
    static func forMoviesByName(_ name: String) -> URL {
        let replaced = name.replacingOccurrences(of: " ", with: "+").lowercased()
        return Endpoint.searchMovie(query: replaced).url
    }
    
    static func forTVShowsbyName(_ name: String) -> URL {
        let replaced = name.replacingOccurrences(of: " ", with: "+").lowercased()
        return Endpoint.searchTVShow(query: replaced).url
    }
}
