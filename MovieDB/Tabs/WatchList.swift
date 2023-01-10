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
    request.sortDescriptors = []
    return request
  }
}

struct WatchList: View {
    
    @FetchRequest(fetchRequest: WatchlistMovie.defaultFetchRequest)
    var watchlistMovies: FetchedResults<WatchlistMovie>
    
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var watchlistMovies: FetchedResults<WatchlistMovie>
    
    var body: some View {
        NavigationView {
            List {
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
                    Menu("Sort") {
                        Button {
                            watchlistMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                        } label: {
                            Text("According to Title")
                        }
                        Button {
                            watchlistMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
                        } label: {
                            Text("According to Date Added")
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
