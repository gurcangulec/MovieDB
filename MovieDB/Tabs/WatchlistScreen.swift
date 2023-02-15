//
//  WatchlistScreen.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//
import CoreData
import SwiftUI

struct WatchlistScreen: View {
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.watchlistedMovies.isEmpty {
                VStack {
                    Spacer()
                    NoItemsView(icon: "🧐",
                                title: "You haven't watchlisted any movies or TV shows yet.",
                                message: "You can watchlist movies or TV shows with \"+ Watchlist\" button when you are displaying a movie or a TV show.")
                    Spacer()
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        Text("\(viewModel.watchlistedMovies.count) Titles")
                            .foregroundColor(.primary)
                        Text("Sorted by \(viewModel.sortedByForWatchlist.rawValue)")
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
                                    viewModel.sortedByForWatchlist = .titleAToZ
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("A - Z")
                                }
                                Button {
                                    viewModel.sortedByForWatchlist = .titleZToA
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Z - A")
                                }
                            }
                            Menu("Sort by Date Added") {
                                Button {
                                    viewModel.sortedByForWatchlist = .dateAddedOldToNew
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Oldest to Newest")
                                }
                                Button {
                                    viewModel.sortedByForWatchlist = .dateAddedNewToOld
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Newest to Oldest")
                                }
                            }
                            Menu("Sort by Release Date") {
                                Button {
                                    viewModel.sortedByForWatchlist = .releaseDateOldToNew
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Oldest to Newest")
                                }
                                Button {
                                    viewModel.sortedByForWatchlist = .releaseDateNewToOld
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: false)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Newest to Oldest")
                                }
                            }
                            Menu("Sort by TMDB Rating") {
                                Button {
                                    viewModel.sortedByForWatchlist = .ratingHighToLow
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Highest to Lowest")
                                }
                                Button {
                                    viewModel.sortedByForWatchlist = .ratingLowToHigh
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: true)
                                    viewModel.fetchWatchlistedMovies()
                                } label: {
                                    Text("Lowest to Highest")
                                }
                            }
                        } label: {
                            HStack {
                                Label("Sort", systemImage: "arrow.up.arrow.down")
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
}

//struct WatchlistScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchlistScreen()
//    }
//}
