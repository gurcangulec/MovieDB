//
//  WatchList.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//
import CoreData
import SwiftUI

//extension StoredMovie {
//    static var defaultFetchRequest: NSFetchRequest<StoredMovie> {
//        let request: NSFetchRequest<StoredMovie> = StoredMovie.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        request.predicate = NSPredicate(format: "watchlisted == true")
//        return request
//    }
//    static var ratedFetchRequest: NSFetchRequest<StoredMovie> {
//        let request: NSFetchRequest<StoredMovie> = StoredMovie.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        request.predicate = NSPredicate(format: "rated == true")
//        return request
//    }
//}

struct WatchList: View {
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.watchlistedMovies.isEmpty {
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
                        Text("\(viewModel.watchlistedMovies.count) Titles")
                            .foregroundColor(.primary)
                        Text("Sorted by \(viewModel.sortedBy.rawValue)")
                            .foregroundColor(.secondary)
                    }
                    
                    ForEach(viewModel.watchlistedMovies) { storedMovie in
                        WatchlistMovieRow(viewModel: viewModel, storedMovie: storedMovie)
                    }
                    .onDelete(perform: deleteWatchlistMovies)
                    
                }
                .listStyle(.plain)
                .navigationTitle("Watchlist")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Menu("Sort by Title") {
                                Button {
                                    viewModel.sortedBy = .title
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("A to Z")
                                }
                                Button {
                                    viewModel.sortedBy = .title
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Z to A")
                                }
                            }
                            Menu("Sort by Date Added") {
                                Button {
                                    viewModel.sortedBy = .dateAdded
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    viewModel.sortedBy = .dateAdded
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
                                    viewModel.sortedBy = .releaseDate
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by Release Date") {
                                Button {
                                    viewModel.sortedBy = .releaseDate
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    viewModel.sortedBy = .releaseDate
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: false)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by TMDB Rating") {
                                Button {
                                    viewModel.sortedBy = .rating
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    viewModel.sortedBy = .rating
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
                                    viewModel.fetchWatchlistedMovies()
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
        guard let index = offsets.first else { return }
        let watchlistedMovie = viewModel.watchlistedMovies[index]
        
        watchlistedMovie.watchlisted = false
        
        if watchlistedMovie.rated == false {
            viewModel.context.delete(watchlistedMovie)
        }
       
        
        viewModel.saveData()
    }
    
//
//    func deleteWatchlistMovies(at offsets: IndexSet) {
//        for offset in offsets {
//            let storedMovie = storedMovies[offset]
//
//            moc.delete(storedMovie)
//        }
//
//        try? moc.save()
//    }
}

//struct WatchList_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchList()
//    }
//}
