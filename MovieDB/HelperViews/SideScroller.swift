//
//  SideScrollerCast.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 08.01.2023.
//

import SwiftUI
import Kingfisher

struct SideScroller: View {
    @ObservedObject var viewModel: TheViewModel
    
    let tvShows: [TVShow]?
    let movies: [Movie]?
    let cast: [CastMember]?
    let crew: [CrewMember]?
    let url: String?
    let geoWidth: Double

    var body: some View {
        if cast != nil {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    if let cast = cast {
                        ForEach(cast) {castMember in
                            NavigationLink {
                                ActorView(viewModel: viewModel, cast: castMember)
                            } label: {
                                VStack {
                                    if castMember.unwrappedProfilePath != "Unknown" {
                                        if let url {
                                            ImageView(urlString: "\(url)\(castMember.unwrappedProfilePath)",
                                                      width: geoWidth * 0.27,
                                                      height: geoWidth * 0.405 )
                                        }
                                        
                                    } else {
                                        ImageView(urlString: nil,
                                                  width: geoWidth * 0.27,
                                                  height: geoWidth * 0.405)
                                        
                                    }
                                    
                                    VStack(spacing: 10) {
                                        Text(castMember.originalName)
                                            .font(.headline)
                                            .frame(maxWidth: geoWidth * 0.27, alignment: .leading)
                                        
                                        Text(castMember.character)
                                            .font(.caption)
                                            .frame(maxWidth: geoWidth * 0.27, alignment: .leading)
                                    }
                                    .frame(alignment: .leading)
                                }
                                .padding(.bottom)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        } else if movies != nil {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    if let movies = movies {
                        ForEach(movies) {movie in
                            NavigationLink {
                                MovieView(viewModel: viewModel, movie: movie)
                            } label: {
                                VStack {
                                    if movie.unwrappedPosterPath != "Unknown" {
                                        ImageView(urlString: "\(url ?? "")\(movie.unwrappedPosterPath)",
                                                  width: geoWidth * 0.27,
                                                  height: geoWidth * 0.405 )
                                        
                                    } else {
                                        ImageView(urlString: nil,
                                                  width: geoWidth * 0.27,
                                                  height: geoWidth * 0.405)
                                        
                                    }
                                    
                                    VStack(spacing: 10) {
                                        Text(movie.originalTitle)
                                            .font(.headline)
                                            .frame(maxWidth: geoWidth * 0.27, alignment: .leading)
                                        
                                        Text("\(movie.formattedReleaseDateForViews)")
                                            .font(.caption)
                                            .frame(maxWidth: geoWidth * 0.27, alignment: .leading)
                                    }
                                    .frame(alignment: .leading)
                                }
                                .padding(.bottom)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.leading, 10)
            }
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    if let tvShows = tvShows {
                        ForEach(tvShows) {tvShow in
                            NavigationLink {
                                TVShowView(tvShow: tvShow)
                            } label: {
                                VStack {
                                    if tvShow.unwrappedPosterPath != "Unknown" {
                                        ImageView(urlString: "\(url ?? "")\(tvShow.unwrappedPosterPath)",
                                                  width: geoWidth * 0.27,
                                                  height: geoWidth * 0.405 )
                                        
                                    } else {
                                        ImageView(urlString: nil,
                                                  width: geoWidth * 0.27,
                                                  height: geoWidth * 0.405)
                                        
                                    }
                                    
                                    VStack(spacing: 10) {
                                        Text(tvShow.originalTitle)
                                            .font(.headline)
                                            .frame(maxWidth: geoWidth * 0.27, alignment: .leading)
                                        
                                        Text("\(tvShow.formattedReleaseDateForViews)")
                                            .font(.caption)
                                            .frame(maxWidth: geoWidth * 0.27, alignment: .leading)
                                    }
                                    .frame(alignment: .leading)
                                }
                                .padding(.bottom)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }.padding(.leading, 10)
        }
    }
}

//struct SideScrollerCast_Previews: PreviewProvider {
//    static var previews: some View {
//        SideScrollerCast()
//    }
//}
