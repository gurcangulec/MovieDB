//
//  Actor.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 08.07.2022.
//

import Foundation

struct Actor: Codable, Identifiable {
    var id: Int?
    var biography: String?
    var birthday: String?
    var profilePath: String?
    var placeOfBirth: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case biography = "biography"
        case birthday = "birthday"
        case profilePath = "profile_path"
        case placeOfBirth = "place_of_birth"
    }
    
    var formattedBirthday: String {
        // Unwrapping releaseDate
        if let birthday = birthday {
            // Formatting as a date
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            
            if let date = formatter.date(from: birthday) {
                let formatted = date.formatted(date: .abbreviated, time: .omitted)
                return formatted
            }
        }
        // If date is nil
        return "N/A"
    }
    
    var formattedBiography: String {
        if biography == "" || biography == nil {
            return "No biography found for this person."
        }
        else {
            if let biography = biography {
                return biography
            }
        }
        return ""
    }
    
    static let example = Actor(id: 100, biography: "Elizabeth Chase Olsen (born February 16, 1989) is an American actress. Born in Sherman Oaks, California, Olsen began acting at age four. She starred in her debut film role in the thriller Martha Marcy May Marlene in 2011, for which she was acclaimed and nominated for a Critics\' Choice Movie Award among other accolades, followed by a role in the horror film Silent House. Olsen received a BAFTA Rising Star Award nomination and graduated from New York University two years later.\n\nOlsen gained worldwide recognition for her portrayal of Wanda Maximoff / Scarlet Witch in the Marvel Cinematic Universe media franchise, appearing in the superhero films Avengers: Age of Ultron (2015), Captain America: Civil War (2016), Avengers: Infinity War (2018), and Avengers: Endgame (2019), and Doctor Strange in the Multiverse of Madness (2022). She also starred as the character in the miniseries WandaVision (2021).", birthday: "2022", profilePath: "/2mcg07areWJ4EAtDvafRz7eDVvb", placeOfBirth: "Uvalde")
}
