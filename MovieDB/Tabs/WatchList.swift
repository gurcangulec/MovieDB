//
//  WatchList.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//
import CoreData
import SwiftUI

// Might not be the best way to implement it
enum SortedBy: String {
    case title = "Title"
    case dateAdded = "Date Added"
    case releaseDate = "Release Date"
    case rating = "TMBD Rating"
}

struct WatchList: View {
    
    @State var sortedBy = SortedBy.title
    
    @FetchRequest(fetchRequest: StoredMovie.defaultFetchRequest)
    var storedMovies: FetchedResults<StoredMovie>
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            if storedMovies.isEmpty {
                VStack {
                    Image(systemName: "play.circle")
                        .font(.title)
                        .padding(.bottom)
                    Text("You haven't watchlisted anything yet.")
                        .navigationTitle("Watchlist")
                        .font(.footnote)
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        Text("\(storedMovies.count) Titles")
                            .foregroundColor(.primary)
                        Text("Sorted by \(sortedBy.rawValue)")
                            .foregroundColor(.secondary)
                    }
                    
                    ForEach(storedMovies) { storedMovie in
                        WatchlistMovieRow(storedMovie: storedMovie)
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
                            Menu("Sort by Title") {
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                                    sortedBy = .title
                                } label: {
                                    Text("A to Z")
                                }
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
                                    sortedBy = .title
                                } label: {
                                    Text("Z to A")
                                }
                            }
                            Menu("Sort by Date Added") {
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
                                    sortedBy = .dateAdded
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
                                    sortedBy = .releaseDate
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by Release Date") {
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: true)]
                                    sortedBy = .dateAdded
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
                                    sortedBy = .releaseDate
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by TMDB Rating") {
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: true)]
                                    sortedBy = .rating
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: false)]
                                    sortedBy = .rating
                                } label: {
                                    Text("Descending Order")
                                }
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
    }
    
    func deleteWatchlistMovies(at offsets: IndexSet) {
        for offset in offsets {
            let storedMovie = storedMovies[offset]
            
            moc.delete(storedMovie)
        }
        
        try? moc.save()
    }
}

struct WatchList_Previews: PreviewProvider {
    static var previews: some View {
        WatchList()
    }
}
