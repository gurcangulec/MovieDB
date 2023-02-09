//
//  Cast.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.07.2022.
//

import Foundation

struct Crew: Codable {
    var results: [CrewMember]
    
    enum CodingKeys: String, CodingKey {
        case results = "crew"
    }
}

struct CrewMember: Codable, Identifiable {
    var id = UUID()
    var crewMemberId: Int
    var originalName: String
    var profilePath: String?
    var job: String?
    var knownForDepartment: String?
    
    enum CodingKeys: String, CodingKey {
        case crewMemberId = "id"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case job
        case knownForDepartment = "known_for_department"
    }
}


struct Cast: Codable {
    var results: [CastMember]
    
    enum CodingKeys: String, CodingKey {
        case results = "cast"
    }
}

struct CastMember: Codable, Identifiable {
    var id: Int
    var originalName: String
    var character: String?
    var profilePath: String?
    var job: String?
    var roles: [Role]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case character
        case profilePath = "profile_path"
        case job
        case roles
    }
    
    var unwrappedProfilePath: String {
        profilePath ?? "Unknown"
    }
    
    static let example = CastMember(id: 100, originalName: "Matthew Mcconaughey", character: "Cooper", profilePath: "2mcg07areWJ4EAtDvafRz7eDVvb.jpg", job: "Police", roles: [Role.example])
}

struct Role: Codable {
    let character: String
    let episodeCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case character
        case episodeCount = "episode_count"
    }
    
    static let example = Role(character: "Joel Miller", episodeCount: 9)
}
