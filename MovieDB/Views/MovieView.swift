//
//  MovieView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 06.07.2022.
//

import CoreHaptics
import SwiftUI
import Kingfisher

struct MovieView: View {
    
    @ObservedObject var viewModel: TheViewModel
    
    @Environment(\.managedObjectContext) var moc

    @StateObject var hapticEngine = Haptics()
    
    let movie: Movie
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    if let unwrappedPath = movie.backdropPath {
                        let unwrappedPath = URL(string: "\(Constants.imageURL)\(unwrappedPath)")
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
                            Text(movie.title)
                                .font(.title.weight(.semibold))
                                .padding(.bottom, geo.size.height * 0.01)

                            HStack {
                                Image(systemName: "star.fill")
                                Text("\(movie.convertRatingToString)/10")
                                    .font(.body)

                                Spacer()

                                Image(systemName: "calendar")
                                Text("\(movie.formattedReleaseDateForViews)")
                                    .font(.body)

                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            .padding(.bottom, geo.size.height * 0.01)

                            Text(movie.overview)
                                .textSelection(.enabled)
                                .font(.body)
                                .padding(.bottom, geo.size.height * 0.01)

                            HStack {
                                Button {
                                    viewModel.showingSheetWatchlist.toggle()
                                    hapticEngine.complexSuccess()

                                } label: {
                                    if viewModel.fetchWatchlistedMovie(movie: movie) {
                                        Label("In Watchlist", systemImage: "plus")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    } else {
                                        Label("Watchlist", systemImage: "plus")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .disabled(viewModel.fetchWatchlistedMovie(movie: movie))

                                Button {
                                    viewModel.showingSheetRating.toggle()
                                    hapticEngine.complexSuccess()

                                } label: {
                                    if viewModel.fetchRatedMovie(movie: movie) {
                                        Label("Rated", systemImage: "star.fill")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    } else {
                                        Label("Rate", systemImage: "star.fill")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .disabled(viewModel.fetchRatedMovie(movie: movie))
                            }
                        }
                        .sheet(isPresented: $viewModel.showingSheetWatchlist) {
                            AddToWatchlistView(viewModel: viewModel, movie: movie, tvShow: nil, width: geo.size.width * 0.54, height: geo.size.width * 0.81)
                        }
                        .sheet(isPresented: $viewModel.showingSheetRating, content: {
                            AddRatingView(viewModel: viewModel, movie: movie, tvShow: nil, width: geo.size.width * 0.54, height: geo.size.width * 0.81)
                        })
                        .onAppear {
                            hapticEngine.prepareHaptics()
                        }
                        
                        Divider()

                        HStack {
                            Text("Cast")
                                .font(.title2.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, geo.size.height * 0.001)

                            NavigationLink {
                                FullCrewView(movie: movie, tvShow: nil, cast: viewModel.cast, crew: viewModel.crew)
                            } label: {
                                Text("Full Cast & Crew")

                                Image(systemName: "chevron.right")
                            }
                        }
                        
                        SideScroller(viewModel: viewModel, tvShows: nil, movies: nil, cast: viewModel.cast, crew: nil, url: Constants.imageURL, geoWidth: geo.size.width)

                        Divider()
                        
                        Group {
                            VStack {
                                Text("Director(s)")
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, geo.size.height * 0.001)

                                ForEach(viewModel.crew) { crewMember in
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
                            
                            ForEach(viewModel.writers, id:\.self) { writer in
                                    Text(writer)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, geo.size.height * 0.01)
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    .task {
                        await viewModel.fetchCastAndCrew(movieId: movie.id)
                    }
                    .refreshable {
                        await viewModel.fetchCastAndCrew(movieId: movie.id)
                    }
                }
            }
            .navigationTitle(movie.title)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu {
                Menu("Copy Link") {
                    Button {
                        viewModel.copyToClipboard(movie: movie, tvShow: nil)
                    } label: {
                        Label("Copy TMDB Link", systemImage: "link")
                    }

                    Button {
                        viewModel.copyToClipboardIMDB()
                    } label: {
                        Label("Copy IMDB Link", systemImage: "link")
                    }
                }

                Menu("Share Link") {
                    Button {
                        viewModel.shareButton(movie: movie, tvShow: nil)
                    } label: {
                        Label("Share TMBD Link", systemImage: "square.and.arrow.up")
                    }

                    Button {
                        viewModel.shareImdbButton()
                    } label: {
                        Label("Share IMDB Link", systemImage: "square.and.arrow.up")
                    }
                }
            } label: {
                Label("Share Options", systemImage: "square.and.arrow.up")
            }
            .onAppear(perform: hapticEngine.prepareHaptics)
            .onTapGesture(perform: hapticEngine.complexSuccess)
        }
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView(movie: .example)
//    }
//}
