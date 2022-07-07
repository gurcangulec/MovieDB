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

struct CastMember: Codable, Identifiable {
    var id: Int
    var originalName: String
    var character: String
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalName = "original_name"
        case character = "character"
        case profilePath = "profile_path"
    }
    
//    static let example = CastMember(id: 100, originalName: "Matthew Mcconaughey", character: "Cooper", profilePath: "/2mcg07areWJ4EAtDvafRz7eDVvb")
}
