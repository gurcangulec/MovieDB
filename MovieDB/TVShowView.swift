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
//                                    showingSheetWatchlist.toggle()
                                    
//                                    do {
//                                        try moc.save()
//                                    } catch {
//                                        print("Something went wrong while saving: \(error.localizedDescription)")
//                                    }
                                    
//                                    hapticEngine.complexSuccess()
                                    
                                } label: {
                                    Label("Watchlist", systemImage: "plus")
                                        .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                }
                                .buttonStyle(.bordered)
                                
                                Button {
//                                    showingSheetRating.toggle()
//                                    hapticEngine.complexSuccess()
                                    
                                } label: {
                                    Label("Rate", systemImage: "star.fill")
                                        .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                }
                                .buttonStyle(.bordered)
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
//            Menu {
//                Menu("Copy Link") {
//                    Button {
//                        viewModel.copyToClipboard(movie: nil, tvShow: tvShow)
//                    } label: {
//                        Label("Copy TMDB Link", systemImage: "link")
//                    }
//
//                    Button {
//                        viewModel.copyToClipboardIMDB()
//                    } label: {
//                        Label("Copy IMDB Link", systemImage: "link")
//                    }
//                }
//
                Menu("Share") {
                    Button {
                        viewModel.shareButton(movie: nil, tvShow: tvShow)
                    } label: {
                        Label("Share TMBD Link", systemImage: "square.and.arrow.up")
                    }

//                    Button {
//                        viewModel.shareImdbButton()
//                    } label: {
//                        Label("Share IMDB Link", systemImage: "square.and.arrow.up")
//                    }
                }
//
//                Button {
//                    print("Add to Watchlist")
//                } label: {
//                    Label("Add to Watchlist", systemImage: "play.circle.fill")
//                }
//
//            } label: {
//                Label("Options", systemImage: "ellipsis")
//            }
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
