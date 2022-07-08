//
//  MovieView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 06.07.2022.
//

import SwiftUI
import Kingfisher
import ExpandableText

struct MovieView: View {
    let movie: Movie
    @State private var cast = [CastMember]()
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    if let unwrappedPath = movie.backdropPath {
                        let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                        KFImage(unwrappedPath)
                            .placeholder {
                                ProgressView()
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                            
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .frame(width: geo.size.width, height: geo.size.width * 0.55)
                    }
                    
                    VStack(alignment: .leading) {
                        Divider()
                        
                        Text(movie.originalTitle)
                            .font(.title.weight(.semibold))
                            .padding(.bottom, geo.size.height * 0.01)
                        
                        Text(movie.overview)
                            .font(.body)
                            .padding(.bottom, geo.size.height * 0.01)
                        
                        HStack {
                            Image(systemName: "star.fill")
                            Text("\(movie.convertToString)/10")
                                .font(.body)
                        }
                        
                        Divider()
                        
                        Text("Cast")
                            .font(.title.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, geo.size.height * 0.01)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(cast) {castMember in
                                    NavigationLink {
                                        ActorView(movie: movie, cast: castMember)
                                    } label: {
                                        VStack {
                                            if let unwrappedPath = castMember.profilePath {
                                                let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                                                KFImage(unwrappedPath)
                                                    .placeholder {
                                                        ProgressView()
                                                            .frame(width: geo.size.width * 0.3)
                                                    }
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geo.size.width * 0.3, height: geo.size.width * 0.45)
                                                    .clipped()
                                                    .cornerRadius(10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(
                                                                Color.gray
                                                                    .opacity(0.5)
                                                            )
                                                    )
                                                    .padding([.top, .bottom, .trailing], 5)

                                            } else {
                                                Image(systemName: "photo")
                                                    .font(.system(size: 20))
                                                    .frame(width: geo.size.width * 0.3, height: geo.size.width * 0.45)
                                                    .aspectRatio(3.8, contentMode: .fit)
                                                    .clipped()
                                                    .cornerRadius(10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(
                                                                Color.gray
                                                                    .opacity(0.5)
                                                            )
                                                    )
                                                    .padding([.top, .bottom, .trailing], 5)
                                            }
                                            
                                            VStack(spacing: 10) {
                                                Text(castMember.originalName)
                                                    .font(.headline)
                                                    .frame(maxWidth: geo.size.width * 0.3, alignment: .leading)
                                                
                                                Text(castMember.character)
                                                    .font(.caption)
                                                    .frame(maxWidth: geo.size.width * 0.3, alignment: .leading)
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
                    .padding(.horizontal)
                    .task {
                        cast = await FetchData.downloadCast(movieId: movie.id)
                    }
                }
            }
            .navigationTitle(movie.originalTitle)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: .example)
    }
}
