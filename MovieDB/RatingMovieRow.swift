//
//  RatingMovieRow.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI

//struct RatingMovieRow: View {
//    @ObservedObject var watchlistMovie: WatchlistMovie
//    private let url = "https://image.tmdb.org/t/p/original/"
//    
//    let dateFormatter = DateFormatter()
//    let dateNow = Date.now
//    
//    var body: some View {
//        NavigationLink {
//            // Needs to be fixed
//            Text("Details")
//        } label: {
//            HStack {
//                if let unwrappedPath = watchlistMovie.posterPath {
//                    let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
//                    KFImage(unwrappedPath)
//                        .placeholder {
//                            ProgressView()
//                        }
//                        .resizable()
//                        .posterStyle()
//                        
//                } else {
//                    Image(systemName: "photo")
//                        .posterStyle()
//                        .foregroundColor(.white)
//                }
//                GeometryReader { geo in
//                    VStack(alignment: .leading, spacing: 3) {
//                        Text(watchlistMovie.unwrappedTitle)
//                            .font(.headline.bold())
//                        
//                        Text(watchlistMovie.formattedReleaseDate ?? "Unknown Date")
//                            .padding(.bottom)
//                        
//                        VStack(alignment: .leading) {
//                            Text("Date Added")
//                                .font(.headline)
//                            
//                            Text("\(watchlistMovie.unwrappedDate)")
//                                .font(.body)
//                        }
//                        .padding(.bottom)
//                        
//                        HStack {
//                            Image(systemName: "star.fill")
//                            Text("\(watchlistMovie.unwrappedRating)")
//                                .font(.body)
//                        }
//
//                    }
//                    .frame(height: geo.size.height * 0.98)
//                }
//            }
//        }
////        .contextMenu {
////
////            Button {
////                print("Add to Watchlist")
////            } label: {
////                Label("Add to Watchlist", systemImage: "play.circle.fill")
////            }
////
////            Button {
////                print("Share")
////            } label: {
////                Label("Share", systemImage: "square.and.arrow.up")
////            }
////        }
//    }
//}
//
//struct RatingMovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingMovieRow()
//    }
//}
