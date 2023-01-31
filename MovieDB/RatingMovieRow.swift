//
//  RatingMovieRow.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI
import Kingfisher

struct RatingMovieRow: View {
    @ObservedObject var viewModel: TheViewModel
    @ObservedObject var ratedMovie: RatedMovieEntity
    private let url = "https://image.tmdb.org/t/p/original/"
    
    let dateFormatter = DateFormatter()
    let dateNow = Date.now
    
    var body: some View {
        NavigationLink {
            if !ratedMovie.tvShow {
                let movie = Movie(id: Int(ratedMovie.id),
                                  originalTitle: ratedMovie.unwrappedTitle,
                                  overview: ratedMovie.overview ?? "Unkown",
                                  posterPath: ratedMovie.posterPath,
                                  releaseDate: String(ratedMovie.unwrappedReleaseDate),
                                  backdropPath: ratedMovie.unwrappedBackdropPath,
                                  voteAverage: Double(ratedMovie.unwrappedRating)!)
                MovieView(viewModel: viewModel, movie: movie)
            } else {
                let tvShow = TVShow(id: Int(ratedMovie.id),
                                    originalTitle: ratedMovie.unwrappedTitle,
                                    overview: ratedMovie.overview ?? "Unkown",
                                    posterPath: ratedMovie.posterPath,
                                    releaseDate: String(ratedMovie.unwrappedReleaseDate),
                                    backdropPath: ratedMovie.unwrappedBackdropPath,
                                    voteAverage: Double(ratedMovie.unwrappedRating)!)
                TVShowView(viewModel: viewModel, tvShow: tvShow)
            }
        } label: {
            HStack {
                if let unwrappedPath = ratedMovie.posterPath {
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
                        Text(ratedMovie.unwrappedTitle)
                            .font(.headline.bold())
                        
                        Text(ratedMovie.unwrappedReleaseDate)
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Date Rated")
                                .font(.headline)
                            
                            Text("\(ratedMovie.unwrappedDateAdded)")
                                .font(.subheadline)
                        }
                        .padding(.bottom)
                        
                        HStack(alignment: .firstTextBaseline) {
                            
                            Image(systemName: "star.fill")
                                .font(.custom("StarSize", size: 14, relativeTo: .subheadline))
                            Text("\(ratedMovie.unwrappedRating)")
                                .font(.custom("StarSize", size: 16, relativeTo: .subheadline))
                                .padding(.trailing, 10)
                            
                            Image(systemName: "star.fill")
                                .font(.custom("StarSize", size: 14, relativeTo: .subheadline))
                                .foregroundColor(.blue)
                            Text("\(ratedMovie.userRating)")
                                .font(.custom("StarSize", size: 16, relativeTo: .subheadline))
                        }

                    }
                    .frame(height: geo.size.height * 0.98)
                }
            }
        }
    }
}

//struct RatingMovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingMovieRow()
//    }
//}
