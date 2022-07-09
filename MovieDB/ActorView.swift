//
//  ActorView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 08.07.2022.
//

import SwiftUI
import Kingfisher

struct ActorView: View {
    let movie: Movie
    let cast: CastMember
    @State private var actor = Actor.example
    @State private var relatedMovies = [Movie]()
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    VStack {
                        if let unwrappedPath = actor.profilePath {
                            let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                            KFImage(unwrappedPath)
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .scaledToFit()
                                .clipped()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color.gray
                                                .opacity(0.5)
                                        )
                                )
                                .frame(width: geo.size.width * 0.4)
                                .frame(width: geo.size.width * 0.84)
                                .padding([.top, .bottom])
                                
                                
                        } else {
                            Image(systemName: "photo")
                                .font(.system(size: 60))
                                .frame(width: geo.size.width, height: geo.size.width * 0.55)
                        }
                        
                        
                        Divider()
                        
                        Text(actor.formattedBirthday)
                        Text(actor.placeOfBirth)
                            .font(.title2)
                        
                        Divider()
                        
                        Text("Biography")
                            .font(.title.weight(.semibold))
                            .frame(maxWidth: geo.size.width, alignment: .leading)
                            .padding(.bottom, geo.size.height * 0.01)
                        Text(actor.biography)
                            .font(.body)
                            .padding(.bottom, geo.size.height * 0.01)
                        
                        Divider()
                        
                        Text("Movies")
                            .font(.title.bold())
                            .frame(maxWidth: geo.size.width, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(relatedMovies) { relatedMovie in
                                    NavigationLink {
                                        MovieView(movie: relatedMovie)
                                    } label: {
                                        VStack {
                                            if let unwrappedPath = relatedMovie.posterPath {
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
                                                    .frame(width: geo.size.width * 0.28, height: geo.size.width * 0.45)
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
                                                Text(relatedMovie.originalTitle)
                                                    .font(.headline)
                                                    .frame(maxWidth: geo.size.width * 0.3, alignment: .leading)
                                                
//                                                Text(relatedMovie.character)
//                                                    .font(.caption)
//                                                    .frame(maxWidth: geo.size.width * 0.3, alignment: .leading)
                                            }
                                            .frame(alignment: .leading)
                                        }
                                        .padding(.bottom)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .task {
                            relatedMovies = await FetchData.downloadRelatedMovies(personId: cast.id)
                        }
                        
                    }
                    .padding()
                    
                }
                .task{
                    actor = await FetchData.downloadPerson(personId: cast.id)
                }
            }
        }
        .navigationTitle(cast.originalName)
    }
}

struct ActorView_Previews: PreviewProvider {
    static var previews: some View {
        ActorView(movie: .example, cast: .example)
    }
}
