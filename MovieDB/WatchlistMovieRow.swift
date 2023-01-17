//
//  WatchlistMovieRow.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 10.01.2023.
//

/*
 
 Try to combine this view as a generic MovieAndTVShowRow View later.
 
 */

import Kingfisher
import SwiftUI

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct WatchlistMovieRow: View {
    @ObservedObject var storedMovie: StoredMovie
    private let url = "https://image.tmdb.org/t/p/original/"
    
    let dateFormatter = DateFormatter()
    let dateNow = Date.now
    
    var body: some View {
        NavigationLink {
            let movie = Movie(id: Int(storedMovie.id), originalTitle: storedMovie.unwrappedTitle, overview: storedMovie.overview ?? "Unkown", posterPath: storedMovie.posterPath, releaseDate: String(storedMovie.unwrappedReleaseDate), backdropPath: storedMovie.unwrappedBackdropPath, voteAverage: Double(storedMovie.unwrappedRating)!)
            MovieView(movie: movie)
        } label: {
            HStack {
                if let unwrappedPath = storedMovie.posterPath {
                    let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                    KFImage(unwrappedPath)
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .posterStyle()
                        
                } else {
                    Image(systemName: "photo")
                        .posterStyle()
                        .foregroundColor(.white)
                }
                GeometryReader { geo in
                    VStack(alignment: .leading, spacing: 3) {
                        Text(storedMovie.unwrappedTitle)
                            .font(.headline.bold())
                        
                        Text(storedMovie.unwrappedReleaseDate)
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Date Added")
                                .font(.headline)
                            
                            Text("\(storedMovie.unwrappedDateAdded)")
                                .font(.subheadline)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.custom("StarSize", size: 14, relativeTo: .subheadline))
                            Text("\(storedMovie.unwrappedRating)")
                                .font(.custom("StarSize", size: 16, relativeTo: .subheadline))
                                .padding(.trailing, 10)
                        }

                    }
                    .frame(height: geo.size.height * 0.98)
                }
            }
        }
//        .contextMenu {
//
//            Button {
//                print("Add to Watchlist")
//            } label: {
//                Label("Add to Watchlist", systemImage: "play.circle.fill")
//            }
//
//            Button {
//                print("Share")
//            } label: {
//                Label("Share", systemImage: "square.and.arrow.up")
//            }
//        }
    }
}

//struct WatchlistMovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchlistMovieRow()
//    }
//}
