//
//  Ratings.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI
import CoreData

extension RatedMovie {
  static var defaultFetchRequest: NSFetchRequest<RatedMovie> {
    let request: NSFetchRequest<RatedMovie> = RatedMovie.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "userRating", ascending: true)]
    return request
  }
}

struct Ratings: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var sortedBy = SortedBy.title
    
    @FetchRequest(fetchRequest: RatedMovie.defaultFetchRequest)
    var ratedMovies: FetchedResults<RatedMovie>
    
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
                        RatingMovieRow(ratedMovie: ratedMovie)
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
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                                    sortedBy = .title
                                } label: {
                                    Text("Ascending (Alphabetical)")
                                }
                                Button {
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
                                    sortedBy = .title
                                } label: {
                                    Text("Descending (Alphabetical)")
                                }
                            }
                            Menu("Sort by Date Added") {
                                Button {
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
                                    sortedBy = .dateAdded
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
                                    sortedBy = .releaseDate
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by Release Date") {
                                Button {
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: true)]
                                    sortedBy = .dateAdded
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
                                    sortedBy = .releaseDate
                                } label: {
                                    Text("Descending Order")
                                }
                            }
                            Menu("Sort by TMDB Rating") {
                                Button {
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: true)]
                                    sortedBy = .rating
                                } label: {
                                    Text("Ascending Order")
                                }
                                Button {
                                    ratedMovies.nsSortDescriptors = [NSSortDescriptor(key: "rating", ascending: false)]
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
            let ratedMovie = ratedMovies[offset]
            
            moc.delete(ratedMovie)
        }
        
        try? moc.save()
    }
}

struct Ratings_Previews: PreviewProvider {
    static var previews: some View {
        Ratings()
    }
}
