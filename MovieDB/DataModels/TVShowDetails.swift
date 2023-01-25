//
//  TVShowDetails.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 25.01.2023.
//

import CodableX
import Foundation

struct TVShowDetails: Decodable {
    let id: Int
    let createdBy: [Creators]
    let numberOfEpisodes: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdBy = "created_by"
        case numberOfEpisodes = "number_of_episodes"
    }
}

struct Creators: Decodable, Identifiable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
}
