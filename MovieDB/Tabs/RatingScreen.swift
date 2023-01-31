//
//  RatingsList.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI
import CoreData

struct RatingsList: View {
    
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.ratedMovies.isEmpty {
                VStack {
                    Image(systemName: "star.circle")
                        .font(.title)
                        .padding(.bottom)
                    Text("You haven't rated anything yet.")
                        .font(.footnote)
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        Text("\(viewModel.ratedMovies.count) Titles")
                            .foregroundColor(.primary)
                        Text("Sorted by \(viewModel.sortedBy.rawValue)")
                            .foregroundColor(.secondary)
                    }
                    
                    ForEach(viewModel.ratedMovies) { ratedMovie in
                        RatingMovieRow(viewModel: viewModel, ratedMovie: ratedMovie)
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
                                    viewModel.sortedBy = .titleAToZ
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("A - Z")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
                                    viewModel.sortedBy = .titleZToA
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Z - A")
                                }
                            }
                            Menu("Sort by Date Added") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
                                    viewModel.sortedBy = .dateAddedNewToOld
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Newest to Oldest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: true)
                                    viewModel.sortedBy = .dateAddedOldToNew
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Oldest to Newest")
                                }
                            }
                            Menu("Sort by Release Date") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: false)
                                    viewModel.sortedBy = .releaseDateNewToOld
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Newest to Oldest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
                                    viewModel.sortedBy = .releaseDateOldToNew
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Oldest to Newest")
                                }
                            }
                            Menu("Sort by TMDB Rating") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
                                    viewModel.sortedBy = .ratingHighToLow
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Highest to Lowest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: true)
                                    viewModel.sortedBy = .ratingLowToHigh
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Lowest to Highest")
                                }
                            }
                            Menu("Sort by User Rating") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "userRating", ascending: false)
                                    viewModel.sortedBy = .userRatingHighToLow
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Highest to Lowest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "userRating", ascending: true)
                                    viewModel.sortedBy = .userRatingLowToHigh
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Lowest to Highest")
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
        guard let index = offsets.first else { return }
        let ratedMovie = viewModel.ratedMovies[index]

        viewModel.context.delete(ratedMovie)
        viewModel.saveData()
    }
}

//struct Ratings_Previews: PreviewProvider {
//    static var previews: some View {
//        Ratings()
//    }
//}
