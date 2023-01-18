//
//  Watchlist-ViewModel.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 17.01.2023.
//

import Foundation
import CoreData
import SwiftUI

//// Enum for both Watchlist and Ratings View
//enum SortedBy: String {
//    case title = "Title"
//    case dateAdded = "Date Added"
//    case releaseDate = "Release Date"
//    case rating = "TMBD Rating"
//}
//
//extension WatchList {
//    
//    @MainActor
//    class ViewModel: ObservableObject {
//        var storedMovies: [StoredMovie] = []
//        
//        var moc: NSManagedObjectContext?
//        init(moc: NSManagedObjectContext? = nil) {
//              self.moc = moc
//           }
//        
//        @Published var sortedBy = SortedBy.title
//        
//        func deleteWatchlistMovies(at offsets: IndexSet) {
//            for offset in offsets {
//                let storedMovie = storedMovies[offset]
//                
//                moc?.delete(storedMovie)
//            }
//            
//            try? moc?.save()
//        }
//    }
//}
