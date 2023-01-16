//
//  RatedMovie+CoreDataProperties.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//
//

import Foundation
import CoreData


extension RatedMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RatedMovie> {
        return NSFetchRequest<RatedMovie>(entityName: "RatedMovie")
    }

    @NSManaged public var id: Int16
    @NSManaged public var userRating: Int16
    @NSManaged public var dateAdded: Date?
    @NSManaged public var formattedReleaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?
    @NSManaged public var rating: Double
    
    public var unwrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var unwrappedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: dateAdded ?? Date.now)
    }
    
    public var unwrappedRating: String {
        String(format: "%.1f", rating)
    }
}

extension RatedMovie : Identifiable {

}
