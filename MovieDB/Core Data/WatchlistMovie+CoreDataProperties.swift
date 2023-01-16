//
//  WatchlistMovie+CoreDataProperties.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 11.01.2023.
//
//

import Foundation
import CoreData


extension WatchlistMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchlistMovie> {
        return NSFetchRequest<WatchlistMovie>(entityName: "WatchlistMovie")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var id: Int32
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?
    @NSManaged public var rating: Double
    @NSManaged public var userRating: Int16
    @NSManaged public var backdropPath: String?
    
    public var unwrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var unwrappedBackdropPath: String {
        backdropPath ?? "Unknown"
    }
    
    public var unwrappedDate: String {
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
    
    public var unwrappedRating: String {
        String(format: "%.1f", rating)
    }

}

extension WatchlistMovie : Identifiable {

}
