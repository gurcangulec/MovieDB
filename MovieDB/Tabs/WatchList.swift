//
//  WatchList.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//
import CoreData
import SwiftUI

extension StoredMovie {
    static var defaultFetchRequest: NSFetchRequest<StoredMovie> {
        let request: NSFetchRequest<StoredMovie> = StoredMovie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "watchlisted == true")
        return request
    }
    static var ratedFetchRequest: NSFetchRequest<StoredMovie> {
        let request: NSFetchRequest<StoredMovie> = StoredMovie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "rated == true")
        return request
    }
}

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
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
//                        Menu {
                            Menu("Sort by Title") {
                                Button {
//                                    viewModel.watchlistedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                                    viewModel.sortedBy = .title
                                } label: {
                                    Text("A to Z")
                                }
                                Button {
//                                    viewModel.watchlistedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
                                    viewModel.sortedBy = .title
                                } label: {
                                    Text("Z to A")
                                }
                            }
//                            Menu("Sort by Date Added") {
//                                Button {
//                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
//                                    viewModel.sortedBy = .dateAdded
//                                } label: {
//                                    Text("Ascending Order")
//                                }
//                                Button {
//                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
//                                    viewModel.sortedBy = .releaseDate
//                                } label: {
//                                    Text("Descending Order")
//                                }
//                            }
//                            Menu("Sort by Release Date") {
//                                Button {
//                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: true)]
//                                    viewModel.sortedBy = .dateAdded
//                                } label: {
//                                    Text("Ascending Order")
//                                }
//                                Button {
//                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
//                                    viewModel.sortedBy = .releaseDate
//                                } label: {
//                                    Text("Descending Order")
//                                }
//                            }
//                            Menu("Sort by TMDB Rating") {
//                                Button {
//                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: true)]
//                                    viewModel.sortedBy = .rating
//                                } label: {
//                                    Text("Ascending Order")
//                                }
//                                Button {
//                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: false)]
//                                    viewModel.sortedBy = .rating
//                                } label: {
//                                    Text("Descending Order")
//                                }
//                            }
//                        } label: {
//                            HStack {
//                                Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
//                                Text("Sort")
//                            }
//                        }
                    }
                }
            }
        }
    }
    
    func deleteWatchlistMovies(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let watchlistedMovie = viewModel.watchlistedMovies[index]
        viewModel.context.delete(watchlistedMovie)
        
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
