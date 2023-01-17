//
//  Ratings.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI
import CoreData

struct Ratings: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var sortedBy = SortedBy.title
    
    @FetchRequest(fetchRequest: StoredMovie.ratedFetchRequest)
    var storedMovies: FetchedResults<StoredMovie>
    
    var body: some View {
        NavigationView {
            if storedMovies.isEmpty {
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
                        Text("\(storedMovies.count) Titles")
                            .foregroundColor(.primary)
                        Text("Sorted by \(sortedBy.rawValue)")
                            .foregroundColor(.secondary)
                    }
                    
                    ForEach(storedMovies) { storedMovie in
                        RatingMovieRow(storedMovie: storedMovie)
                    }
                    .onDelete(perform: deleteRatedMovies)
                    
                }
                .listStyle(.plain)
                .navigationTitle("Your Ratings")
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
                                    Text("Ascending (Alphabetical)")
                                }
                                Button {
                                    storedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
                                    sortedBy = .title
                                } label: {
                                    Text("Descending (Alphabetical)")
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
    func deleteRatedMovies(at offsets: IndexSet) {
        for offset in offsets {
            let storedMovie = storedMovies[offset]
            
            moc.delete(storedMovie)
        }
        
        try? moc.save()
    }
}

struct Ratings_Previews: PreviewProvider {
    static var previews: some View {
        Ratings()
    }
}
