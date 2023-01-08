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
    @State private var crew = [CrewMember]()
    private let url = "https://image.tmdb.org/t/p/original/"
    
    @State private var showShareSheet = false
    
    var writers: [String] {
        var writtenByArray = [String]()
        var storyByArray = [String]()
        var screenplayByArray = [String]()
        
        for member in crew {
            if member.job == "Writer" {
                let addToArray = "\(member.originalName) (written by)"
                writtenByArray.append(addToArray)
            } else if member.job == "Story" {
                let addToArray = "\(member.originalName) (story by)"
                storyByArray.append(addToArray)
            } else if member.job == "Screenplay" {
                let addToArray = "\(member.originalName) (screenplay by)"
                screenplayByArray.append(addToArray)
            }
        }
        
        return writtenByArray + storyByArray + screenplayByArray
    }
    
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
                        
                        Group {
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
                                
                                Spacer()
                                
                                Image(systemName: "calendar")
                                Text("\(movie.formattedReleaseDate)")
                                    .font(.body)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                        }
                        
                        Divider()
                        
                        Text("Cast")
                            .font(.title2.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, geo.size.height * 0.001)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
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
                                                    .foregroundColor(.white)
                                                    .background(.gray)
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
                            .toolbar {
                                Menu {
                                    Button {
                                        print("Add to Watchlist")
                                    } label: {
                                        Label("Add to Watchlist", systemImage: "play.circle.fill")
                                    }
                                    
                                    Button {
                                        shareButton()
                                        
                                    } label: {
                                        Label("Share", systemImage: "square.and.arrow.up")
                                    }
                                } label: {
                                    Label("Options", systemImage: "ellipsis")
                                }
                            }
//                            .sheet(isPresented: $showShareSheet) {
//                                MenuFunctionality.shareButton()
//                            }
                        }
                        
                        Group {
                            VStack {
                                Text("Director(s)")
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, geo.size.height * 0.001)
                                
                                ForEach(crew) { crewMember in
                                    if crewMember.job == "Director" {
                                        Text(crewMember.originalName)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.bottom, geo.size.height * 0.01)
                                    }
                                }
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Writer(s)")
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, geo.size.height * 0.001)
                            }
                            
                            ForEach(writers, id:\.self) { writer in
                                    Text(writer)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, geo.size.height * 0.01)
                            }
                            
                            Divider()
                            
                            NavigationLink {
                                FullCrewView(movie: movie, cast: cast, crew: crew)
                            } label: {
                                Text("Full Cast & Crew")
                                
                                Image(systemName: "chevron.right")
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding(.horizontal)
                    .task {
                        cast = await FetchData.downloadCast(movieId: movie.id)
                        crew = await FetchData.downloadCrew(movieId: movie.id)
                    }
                }
            }
            .navigationTitle(movie.originalTitle)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addToWatchlist() { }
    func shareButton() {
        
        let activityController = UIActivityViewController(activityItems: ["https://www.themoviedb.org/movie/\(movie.id)"], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: .example)
    }
}
