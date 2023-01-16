//
//  Ratings.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI

struct Ratings: View {
    
    @State var sortedBy = SortedBy.title
    
    @FetchRequest(fetchRequest: WatchlistMovie.defaultFetchRequest)
    var ratedMovies: FetchedResults<WatchlistMovie>
    
    var body: some View {
        NavigationView {
            if ratedMovies.isEmpty {
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
                        Text("\(ratedMovies.count) Titles")
                            .foregroundColor(.primary)
                        Text("Sorted by \(sortedBy.rawValue)")
                            .foregroundColor(.secondary)
                    }
                    
                    ForEach(ratedMovies) { ratedMovie in
                        //                    ratedMovie(watchlistMovie: ratedMovie)
                    }
                    //                .onDelete(perform: deleteWatchlistMovies)
                    
                }
                .listStyle(.plain)
                .navigationTitle("Your Ratings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Button {
                                ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                                sortedBy = .title
                            } label: {
                                Text("Sort by Title (Alphabetical)")
                            }
                            Button {
                                ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
                                sortedBy = .dateAdded
                            } label: {
                                Text("Sort by Date Added")
                            }
                            Button {
                                ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "formattedReleaseDate", ascending: false)]
                                sortedBy = .releaseDate
                            } label: {
                                Text("Sort by Release Date")
                            }
                            Button {
                                ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: false)]
                                sortedBy = .rating
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
    }
}

struct Ratings_Previews: PreviewProvider {
    static var previews: some View {
        Ratings()
    }
}
