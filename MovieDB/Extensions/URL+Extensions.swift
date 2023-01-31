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
        
        var url: URL {
            var components = URLComponents()
            components.host = "api.themoviedb.org"
            components.scheme = "https"
            components.path = "/3"
            switch self {
            case .configuration:
                components.path = "/configuration"
                components.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.APIKEY)
                ]
            }
            return components.url!
        }
    }
}
