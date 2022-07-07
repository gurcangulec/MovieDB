//
//  Cast.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.07.2022.
//

import Foundation

struct Cast: Codable {
    var results: [CastMember]
    
    enum CodingKeys: String, CodingKey {
        case results = "cast"
    }
}

struct CastMember: Codable {
    var id: Int
    var originalName: String
    var character: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalName = "original_name"
        case character = "characters"
    }
    
    static let example = CastMember(id: 100, originalName: "Matthew Mcconaughey", character: "Cooper")
}
