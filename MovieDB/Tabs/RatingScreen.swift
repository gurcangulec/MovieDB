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
                    Spacer()
                    NoItemsView(icon: "🧐",
                                title: "You haven't rated any movies or TV shows yet.",
                                message: "You can rate movies or TV shows by clicking on the \"Rate\" button when you're viewing a particular movie or TV show.")
                    Spacer()
                }
            } else {
                List {
                    VStack(alignment: .leading) {
                        Text("\(viewModel.ratedMovies.count) Titles")
                            .foregroundColor(.primary)
                        Text("Sorted by \(viewModel.sortedByForRated.rawValue)")
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
                                    viewModel.sortedByForRated = .titleAToZ
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("A - Z")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
                                    viewModel.sortedByForRated = .titleZToA
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Z - A")
                                }
                            }
                            Menu("Sort by Date Rated") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
                                    viewModel.sortedByForRated = .dateAddedNewToOld
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Newest to Oldest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: true)
                                    viewModel.sortedByForRated = .dateAddedOldToNew
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Oldest to Newest")
                                }
                            }
                            Menu("Sort by Release Date") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: false)
                                    viewModel.sortedByForRated = .releaseDateNewToOld
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Newest to Oldest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
                                    viewModel.sortedByForRated = .releaseDateOldToNew
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Oldest to Newest")
                                }
                            }
                            Menu("Sort by TMDB Rating") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
                                    viewModel.sortedByForRated = .ratingHighToLow
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Highest to Lowest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "rating", ascending: true)
                                    viewModel.sortedByForRated = .ratingLowToHigh
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Lowest to Highest")
                                }
                            }
                            Menu("Sort by User Rating") {
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "userRating", ascending: false)
                                    viewModel.sortedByForRated = .userRatingHighToLow
                                    viewModel.fetchRatedMovies()
                                } label: {
                                    Text("Highest to Lowest")
                                }
                                Button {
                                    viewModel.sortDescriptor = NSSortDescriptor(key: "userRating", ascending: true)
                                    viewModel.sortedByForRated = .userRatingLowToHigh
                                    viewModel.fetchRatedMovies()
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
