//
//  WatchlistedMovieEntity+CoreDataProperties.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 17.01.2023.
//
//

import Foundation
import CoreData


extension WatchlistedMovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchlistedMovieEntity> {
        return NSFetchRequest<WatchlistedMovieEntity>(entityName: "WatchlistedMovieEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var rating: Double
    @NSManaged public var userRating: Int16
    @NSManaged public var dateAdded: Date?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var posterPath: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var backdropImage: Data?
    @NSManaged public var notes: String?
    @NSManaged public var rated: Bool
    @NSManaged public var watchlisted: Bool
    @NSManaged public var tvShow: Bool
    
    public var unwrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var unwrappedRating: String {
        String(format: "%.1f", rating)
    }
    
    public var unwrappedDateAdded: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: dateAdded ?? Date.now)
    }
    
    public var unwrappedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: releaseDate ?? Date.now)
    }
    
    public var unwrappedBackdropPath: String {
        backdropPath ?? "Unknown"
    }
    
    public var unwrappedPosterPath: String {
        posterPath ?? "Unknown"
    }
}

extension WatchlistedMovieEntity : Identifiable {

}
