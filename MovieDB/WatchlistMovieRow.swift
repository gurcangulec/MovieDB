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
    @ObservedObject var viewModel: TheViewModel
    @ObservedObject var storedMovie: WatchlistedMovieEntity
    private let url = "https://image.tmdb.org/t/p/original/"
    @State private var isShowingNotes = false
    
    let dateFormatter = DateFormatter()
    let dateNow = Date.now
    
    var body: some View {
        NavigationLink {
            if !storedMovie.tvShow {
                let movie = Movie(id: Int(storedMovie.id),
                                  title: storedMovie.wMovieTitle,
                                  overview: storedMovie.wMmovieOverview,
                                  posterPath: storedMovie.wMmoviePosterPath,
                                  releaseDate: String(storedMovie.wMmovieReleaseDate),
                                  backdropPath: storedMovie.wMmovieBackdropPath,
                                  voteAverage: Double(storedMovie.wMmovieRating)!)
                
                MovieView(viewModel: viewModel, movie: movie)
            } else {
                let tvShow = TVShow(id: Int(storedMovie.id),
                                    originalTitle: storedMovie.wMovieTitle,
                                    overview: storedMovie.wMmovieOverview,
                                    posterPath: storedMovie.wMmoviePosterPath,
                                    releaseDate: String(storedMovie.wMmovieReleaseDate),
                                    backdropPath: storedMovie.wMmovieBackdropPath,
                                    voteAverage: Double(storedMovie.wMmovieRating)!)
                TVShowView(viewModel: viewModel, tvShow: tvShow)
            }
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
                        Text(storedMovie.wMovieTitle)
                            .font(.headline.bold())
                        
                        Text(storedMovie.wMmovieReleaseDate)
                            .font(.subheadline)
                            .padding(.bottom)
                        
                            VStack(alignment: .leading) {
                                Text("Date Added")
                                    .font(.headline)
                                
                                Text("\(storedMovie.wMmovieDateAdded)")
                                    .font(.subheadline)
                            }
//                            .padding(.trailing, 10)
                        
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "star.fill")
                                .font(.custom("StarSize", size: 14, relativeTo: .subheadline))
                            Text("\(storedMovie.wMmovieRating)")
                                .font(.custom("StarSize", size: 16, relativeTo: .subheadline))
//                                .padding(.trailing, 10)
                            
                            Spacer()
                            
                            Button {
                                isShowingNotes.toggle()
                            } label: {
                                Text(storedMovie.notes == "" ? "Add Note" : "Show Note")
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(minWidth: 120, minHeight: 34, alignment: .center)
                                    .background(Color.accentColor)
                                    .cornerRadius(10)
                            }
                            .buttonStyle(.borderless)
                        }

                    }
                    .frame(height: geo.size.height * 0.98)
                    .sheet(isPresented: $isShowingNotes) {
                        Notes(viewModel: viewModel, storedMovie: storedMovie)
                    }
                }
            }
        }
    }
}

//struct WatchlistMovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchlistMovieRow()
//    }
//}
