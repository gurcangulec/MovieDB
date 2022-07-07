//
//  MovieView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 06.07.2022.
//

import SwiftUI
import Kingfisher

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
                            .frame(width: geo.size.width)
                    }
                    
                    VStack(alignment: .leading) {
                        Divider()
                        
                        Text("Overview")
                            .font(.title)
                            .padding(.bottom, 5)
                        
                        Text(movie.overview)
                            .font(.body)
                            .padding(.bottom, 5)
                        
                        Divider()
                        
                        Text("Cast")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 5)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(cast) {castMember in
                                    if let unwrappedPath = castMember.profilePath {
                                        let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                                        KFImage(unwrappedPath)
                                            .placeholder {
                                                ProgressView()
                                                    .frame(width: 75, height: 125)
                                            }
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geo.size.width * 0.2)
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
                                            .frame(width: 75, height: 125)
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
                                    
                                    VStack {
                                        Text(castMember.originalName)
                                            .font(.headline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("as \(castMember.character)")
                                            .font(.caption)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .frame(alignment: .leading)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .task {
                        await downloadCast()
                    }
                }
            }
            .navigationTitle(movie.originalTitle)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @Sendable func downloadCast() async {

            // Check URL
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=c74260965badd03144f9a327f254f0a2&language=en-US") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                // Decode from data
                if let decoded = try? decoder.decode(Cast.self, from: data) {
                    cast = decoded.results
                }
            } catch {
                print("Invalid Something")
            }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: .example)
    }
}
