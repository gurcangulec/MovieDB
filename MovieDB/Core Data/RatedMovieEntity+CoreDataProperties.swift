//
//  RatedMovieEntity+CoreDataProperties.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 24.01.2023.
//
//

import Foundation
import CoreData


extension RatedMovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RatedMovieEntity> {
        return NSFetchRequest<RatedMovieEntity>(entityName: "RatedMovieEntity")
    }

    @NSManaged public var backdropImage: Data?
    @NSManaged public var backdropPath: String?
    @NSManaged public var dateAdded: Date?
    @NSManaged public var id: Int32
    @NSManaged public var notes: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var posterPath: String?
    @NSManaged public var rated: Bool
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var userRating: Int16
    @NSManaged public var watchlisted: Bool
    
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

}

extension RatedMovieEntity : Identifiable {

}
