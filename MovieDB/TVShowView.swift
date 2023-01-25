//
//  TVShowView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import Kingfisher
import SwiftUI

struct TVShowView: View {
    @ObservedObject var viewModel: TheViewModel
    @StateObject var hapticEngine = Haptics()
    
    let tvShow: TVShow
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    if let unwrappedPath = tvShow.backdropPath {
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
                            
                            Text(tvShow.originalTitle)
                                .font(.title.weight(.semibold))
                                .padding(.bottom, geo.size.height * 0.01)
                            HStack {
                                Text("TV Series - \(viewModel.tvShowDetails.numberOfEpisodes) Episodes")
                                    .font(.body.weight(.semibold))
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, geo.size.height * 0.01)
                            }
                            
                            HStack {
                                Image(systemName: "star.fill")
                                Text("\(tvShow.convertToString)/10")
                                    .font(.body)
                                
                                Spacer()
                                
                                Image(systemName: "calendar")
                                Text("\(tvShow.releaseDate ?? "Unknown")")
                                    .font(.body)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            .padding(.bottom, geo.size.height * 0.01)
                            
                            Text(tvShow.overview)
                                .font(.body)
                                .padding(.bottom, geo.size.height * 0.01)
                            
                            HStack {
                                Button {
                                    viewModel.showingSheetWatchlist.toggle()
                                    hapticEngine.complexSuccess()

                                } label: {
                                    if viewModel.fetchWatchlistedTVShow(tvShow: tvShow) {
                                        Label("In Watchlist", systemImage: "plus")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    } else {
                                        Label("Watchlist", systemImage: "plus")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .disabled(viewModel.fetchWatchlistedTVShow(tvShow: tvShow))

                                Button {
                                    viewModel.showingSheetRating.toggle()
                                    hapticEngine.complexSuccess()

                                } label: {
                                    if viewModel.fetchRatedTVShow(tvShow: tvShow) {
                                        Label("Rated", systemImage: "star.fill")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    } else {
                                        Label("Rate", systemImage: "star.fill")
                                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .disabled(viewModel.fetchRatedTVShow(tvShow: tvShow))
                            }
                            .sheet(isPresented: $viewModel.showingSheetWatchlist) {
                                AddToWatchlistView(viewModel: viewModel, movie: nil, tvShow: tvShow, width: geo.size.width * 0.54, height: geo.size.width * 0.81)
                            }
                            .sheet(isPresented: $viewModel.showingSheetRating, content: {
                                AddRatingView(viewModel: viewModel, movie: nil, tvShow: tvShow, width: geo.size.width * 0.54, height: geo.size.width * 0.81)
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
                                    FullCrewView(movie: nil, tvShow: tvShow, cast: viewModel.cast, crew: viewModel.crew)
                                } label: {
                                    Text("Full Cast & Crew")
                                    
                                    Image(systemName: "chevron.right")
                                }
    //                            .padding(.bottom)
                            }
                            
                            SideScroller(viewModel: viewModel, tvShows: nil, movies: nil, cast: viewModel.cast, crew: nil, url: url, geoWidth: geo.size.width)
                            
                            Divider()
                            
                            if !viewModel.tvShowDetails.createdBy.isEmpty {
                                Group {
                                    VStack {
                                        Text("Creator(s)")
                                            .font(.title2.bold())
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.bottom, geo.size.height * 0.001)
                                        
                                        ForEach(viewModel.tvShowDetails.createdBy) { creator in
                                            Text(creator.name)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.bottom, geo.size.height * 0.01)
                                        }
                                    }
                                    
                                    
                                    Divider()
                                }
                            }
                        }
                    }
                    .task {
                        await viewModel.fetchCastAndCrewTVShow(tvShowId: tvShow.id)
                    }
                    .refreshable {
                        await viewModel.fetchCastAndCrewTVShow(tvShowId: tvShow.id)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(tvShow.originalTitle)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        viewModel.copyToClipboard(movie: nil, tvShow: tvShow)
                    } label: {
                        Label("Copy TMBD Link", systemImage: "link")
                    }
                    Button {
                        viewModel.shareButton(movie: nil, tvShow: tvShow)
                    } label: {
                        Label("Share TMBD Link", systemImage: "square.and.arrow.up")
                    }
                  
                } label: {
                    Label("Share Options", systemImage: "square.and.arrow.up")
                }
            }
//            .onAppear(perform: hapticEngine.prepareHaptics)
//            .onTapGesture(perform: hapticEngine.complexSuccess)
        }
    }
}

//struct TVShowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowView()
//    }
//}
