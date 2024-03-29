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
        
        case movieCrewAndCast(movieId: Int)
        case tvShowCrewAndCast(tvShowId: Int)
        
        case popularMovies
        case upcomingMovies
        case topRatedMovies
        
        case popularTVShows
        case onTheAirTVShows
        case topRatedTVShows
        case tvShowCredits(tvShowId: Int)
        
        case relatedMovies(personId: Int)
        case personDetails(personId: Int)
        
        case specificMovie(movieId: Int)
        case specificTVShow(tvShowId: Int)
        
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
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "include_adult", value: "false")
                ]
            case .searchTVShow(let query):
                components.path = "/3/search/tv"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "query", value: query)
                ]
            case .movieCrewAndCast(let movieId):
                components.path = "/3/movie/\(movieId)/credits"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY)
                ]
            case .tvShowCrewAndCast(let tvShowId):
                components.path = "/3/tv/\(tvShowId)/credits"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY)
                ]
            case .popularMovies:
                components.path = "/3/movie/popular"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "with_original_language", value: "en")
                ]
            case .upcomingMovies:
                components.path = "/3/movie/upcoming"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "with_original_language", value: "en")
                ]
            case .topRatedMovies:
                components.path = "/3/movie/top_rated"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "with_original_language", value: "en")
                ]
            case .popularTVShows:
                components.path = "/3/tv/popular"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "with_original_language", value: "en")
                ]
            case .onTheAirTVShows:
                components.path = "/3/tv/on_the_air"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "with_original_language", value: "en")
                ]
            case .topRatedTVShows:
                components.path = "/3/tv/top_rated"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "with_original_language", value: "en")
                ]
            case .tvShowCredits(let tvShowId):
                components.path = "/3/tv/\(tvShowId)/aggregate_credits"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .relatedMovies(let personId):
                components.path = "/3/person/\(personId)/movie_credits"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .personDetails(let personId):
                components.path = "/3/person/\(personId)"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .specificMovie(let movieId):
                components.path = "/3/movie/\(movieId)"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY),
                    URLQueryItem(name: "language", value: "en-US")
                ]
            case .specificTVShow(let tvShowId):
                components.path = "/3/tv/\(tvShowId)"
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
        Endpoint.movieCrewAndCast(movieId: movieId).url
    }
    
    static func forTVShowCastAndCrew(tvShowId: Int) -> URL {
        Endpoint.tvShowCrewAndCast(tvShowId: tvShowId).url
    }
    
    static func forMoviesByName(_ name: String) -> URL {
        let replaced = name.replacingOccurrences(of: " ", with: "+").lowercased()
        return Endpoint.searchMovie(query: replaced).url
    }
    
    static func forTVShowsbyName(_ name: String) -> URL {
        let replaced = name.replacingOccurrences(of: " ", with: "+").lowercased()
        return Endpoint.searchTVShow(query: replaced).url
    }
    
    static func forRelatedMovies(personId: Int) -> URL {
        Endpoint.relatedMovies(personId: personId).url
    }
    
    static func forPersonDetails(personId: Int) -> URL {
        Endpoint.personDetails(personId: personId).url
    }
    
    static func forSpecificMovie(movieId: Int) -> URL {
        Endpoint.specificMovie(movieId: movieId).url
    }
    
    static func forSpecificTVShow(tvshowId: Int) -> URL {
        Endpoint.specificTVShow(tvShowId: tvshowId).url
    }
    
    static func forTVShowCredits(tvShowId: Int) -> URL {
        Endpoint.tvShowCredits(tvShowId: tvShowId).url
    }
}
