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
    
    let dateFormatter = DateFormatter()
    let dateNow = Date.now
    
    var body: some View {
        NavigationLink {
            if !ratedMovie.tvShow {
                let movie = Movie(id: Int(ratedMovie.id),
                                  title: ratedMovie.rMovieTitle,
                                  overview: ratedMovie.rMmovieOverview,
                                  posterPath: ratedMovie.rMmoviePosterPath,
                                  releaseDate: String(ratedMovie.rMmovieReleaseDate),
                                  backdropPath: ratedMovie.rMmovieBackdropPath,
                                  voteAverage: Double(ratedMovie.rMmovieRating)!)
                MovieView(viewModel: viewModel, movie: movie)
            } else {
                let tvShow = TVShow(id: Int(ratedMovie.id),
                                    originalTitle: ratedMovie.rMovieTitle,
                                    overview: ratedMovie.rMmovieOverview,
                                    posterPath: ratedMovie.rMmoviePosterPath,
                                    releaseDate: String(ratedMovie.rMmovieReleaseDate),
                                    backdropPath: ratedMovie.rMmovieBackdropPath,
                                    voteAverage: Double(ratedMovie.rMmovieRating)!)
                TVShowView(viewModel: viewModel, tvShow: tvShow)
            }
        } label: {
            HStack {
                if let unwrappedPath = ratedMovie.posterPath {
                    let unwrappedPath = URL(string: "\(Constants.imageURL)\(unwrappedPath)")
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
                        Text(ratedMovie.rMovieTitle)
                            .font(.headline.bold())
                        
                        Text(ratedMovie.rMmovieReleaseDate)
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Date Rated")
                                .font(.headline)
                            
                            Text("\(ratedMovie.rMmovieDateAdded)")
                                .font(.subheadline)
                        }
                        .padding(.bottom)
                        
                        HStack(alignment: .firstTextBaseline) {
                            
                            Image(systemName: "star.fill")
                                .font(.custom("StarSize", size: 14, relativeTo: .subheadline))
                            Text("\(ratedMovie.rMmovieRating)")
                                .font(.custom("StarSize", size: 16, relativeTo: .subheadline))
                                .padding(.trailing, 10)
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.custom("StarSize", size: 14, relativeTo: .subheadline))
                                    .foregroundColor(.blue)
                                Text("\(ratedMovie.userRating)")
                                    .font(.custom("StarSize", size: 16, relativeTo: .subheadline))
                                
                                Spacer()
                                
                                Menu("Change") {
                                    ForEach(1..<11) { value in
                                        Button("\(value)") {
                                            ratedMovie.userRating = Int16(value)
                                            viewModel.saveData()
                                        }
                                    }
                                }
                                .buttonStyle(.bordered)
                            }
                            .frame(maxWidth: .infinity, minHeight: 24, alignment: .leading)
                            
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
