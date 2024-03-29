//
//  MovieAndTVShowRow.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import Kingfisher

struct MovieAndTVShowRow: View {
    @ObservedObject var viewModel: TheViewModel
    
    let movie: Movie?
    let tvShow: TVShow?
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        // Fix this abomination
        NavigationLink {
            if let movie = movie {
                MovieView(viewModel: viewModel, movie: movie)
            } else {
                if let tvShow = tvShow {
                    TVShowView(viewModel: viewModel, tvShow: tvShow)
                }
            }
        } label: {
            HStack {
                if let movie = movie {
                    if movie.unwrappedPosterPath != "Unknown" {
                        KFImage(URL(string: "\(Constants.imageURL)\(movie.unwrappedPosterPath)"))
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
                            Text(movie.title)
                                .font(.headline.bold())
                            
                            Text(movie.formattedReleaseDateForViews)
                                .padding(.bottom)
                            
                            Text(movie.overview)
                                .font(.body)
                            
                        }
                        .padding(5)
                        .frame(height: geo.size.height * 0.98)
                        
                    }
                } else {
                    if let tvShow = tvShow {
                        if tvShow.unwrappedPosterPath != "Unknown" {
                            KFImage(URL(string: "\(url)\(tvShow.unwrappedPosterPath)"))
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
                                Text(tvShow.originalTitle)
                                    .font(.headline.bold())
                                
                                Text(tvShow.formattedReleaseDateForViews)
                                    .padding(.bottom)
                                
                                Text(tvShow.overview)
                                    .font(.body)
                                
                            }
                            .padding(5)
                            .frame(height: geo.size.height * 0.98)
                        }
                    }
                }
            }
        }
        .contextMenu {
            
            Button {
                print("Add to Watchlist")
            } label: {
                Label("Add to Watchlist", systemImage: "play.circle.fill")
            }
            
            Button {
                print("Share")
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }
    }
}

//
//struct MovieAndTVShowRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRow(movie: .example)
//    }
//}
