//
//  Ratings.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI
import CoreData

struct Ratings: View {
    
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.ratedMovies.isEmpty {
                VStack {
                    Image(systemName: "star.circle")
                        .font(.title)
                        .padding(.bottom)
                    Text("You haven't rated anything yet.")
                        .navigationTitle("Your Ratings")
                        .font(.footnote)
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        Text("\(viewModel.ratedMovies.count) Titles")
                            .foregroundColor(.primary)
//                        Text("Sorted by \(sortedBy.rawValue)")
//                            .foregroundColor(.secondary)
                    }
                    
                    ForEach(viewModel.ratedMovies) { storedMovie in
                        RatingMovieRow(viewModel: viewModel, storedMovie: storedMovie)
                    }
                    .onDelete(perform: deleteRatedMovies)
                    
                }
                .listStyle(.plain)
                .navigationTitle("Your Ratings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Menu("Sort by Title") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
                                    viewModel.sortedBy = .title
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Ascending (Alphabetical)")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
                                    viewModel.sortedBy = .title
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Descending (Alphabetical)")
                                }
                            }
                            Menu("Sort by Date Added") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: true)
                                    viewModel.sortedBy = .dateAdded
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
                                    viewModel.sortedBy = .releaseDate
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by Release Date") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
                                    viewModel.sortedBy = .dateAdded
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: false)
                                    viewModel.sortedBy = .releaseDate
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by TMDB Rating") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: true)
                                    viewModel.sortedBy = .rating
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
                                    viewModel.sortedBy = .rating
                                    viewModel.fetchRatedMovies()
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
    func deleteRatedMovies(at offsets: IndexSet) {
        for offset in offsets {
            let storedMovie = viewModel.ratedMovies[offset]
            
            storedMovie.rated = false
            
            if storedMovie.watchlisted == false {
                viewModel.context.delete(storedMovie)
            }
        }
        
        try? viewModel.context.save()
    }
}

//struct Ratings_Previews: PreviewProvider {
//    static var previews: some View {
//        Ratings()
//    }
//}
