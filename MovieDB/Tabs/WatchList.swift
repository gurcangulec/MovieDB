//
//  WatchList.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//
import CoreData
import SwiftUI

extension WatchlistMovie {
  static var defaultFetchRequest: NSFetchRequest<WatchlistMovie> {
    let request: NSFetchRequest<WatchlistMovie> = WatchlistMovie.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    return request
  }
}

// Might not be the best way to implement it
enum SortedBy: String {
    case title = "Title"
    case dateAdded = "Date Added"
    case releaseDate = "Release Date"
    case rating = "Rating"
}

struct WatchList: View {
    
    @State var sortedBy = SortedBy.title
    
    @FetchRequest(fetchRequest: WatchlistMovie.defaultFetchRequest)
    var watchlistMovies: FetchedResults<WatchlistMovie>
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    Text("\(watchlistMovies.count) Titles")
                        .foregroundColor(.primary)
                    Text("Sorted by \(sortedBy.rawValue)")
                        .foregroundColor(.secondary)
                    }
                                   
                ForEach(watchlistMovies) { watchlistMovie in
                    WatchlistMovieRow(watchlistMovie: watchlistMovie)
                }
                .onDelete(perform: deleteWatchlistMovies)
                
            }
            .listStyle(.plain)
            .navigationTitle("Watchlist")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button {
                            watchlistMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                            sortedBy = SortedBy.title
                        } label: {
                            Text("Sort by Title (Alphabetical)")
                        }
                        Button {
                            watchlistMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
                            sortedBy = SortedBy.dateAdded
                        } label: {
                            Text("Sort by Date Added")
                        }
                        Button {
                            watchlistMovies.nsSortDescriptors = [NSSortDescriptor(key: "formattedReleaseDate", ascending: false)]
                            sortedBy = SortedBy.releaseDate
                        } label: {
                            Text("Sort by Release Date")
                        }
                        Button {
                            watchlistMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: false)]
                            sortedBy = SortedBy.rating
                        } label: {
                            Text("Sort by TMDB Rating")
                        }
                    } label: {
                        HStack {
                            Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
                            Text("Sort")
                        }
                    }
                }
            }
        }
    }
    
    func deleteWatchlistMovies(at offsets: IndexSet) {
        for offset in offsets {
            let watchlistMovie = watchlistMovies[offset]
            
            moc.delete(watchlistMovie)
        }
        
        try? moc.save()
    }
}

struct WatchList_Previews: PreviewProvider {
    static var previews: some View {
        WatchList()
    }
}
