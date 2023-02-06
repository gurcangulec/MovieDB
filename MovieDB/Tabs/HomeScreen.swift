//
//  HomeScreen.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height * 0.001
            NavigationView {
                VStack {
                    ScrollView(showsIndicators: false) {
                        TabView{
                            if viewModel.popularMovies.count >= 1 {
                                ForEach(viewModel.popularMovies.indices, id: \.self) { index in
                                    ZStack(alignment: .center) {
                                        NavigationLink {
                                            MovieView(viewModel: viewModel, movie: viewModel.popularMovies[index])
                                        } label: {
                                            ImageView(urlString: "\(viewModel.imageUrl)\(viewModel.popularMovies[index].unwrappedBackdropPath)", width: width * 0.97, height: geo.size.height * 0.3)
                                        }
                                        Text(viewModel.popularMovies[index].title)
                                            .font(.caption)
                                            .fontWeight(.black)
                                            .padding(8)
                                            .foregroundColor(.white)
                                            .background(.black.opacity(0.75))
                                            .clipShape(Capsule())
                                            .offset(y: height * 120)
                                    }
                                    .tag(index)
                                    .padding(.trailing, 5)
                                }
                            } else {
                                ProgressView()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: geo.size.height * 0.3)
                        
                        Divider()
                        
                        HomeSectionsView(viewModel: viewModel, title: viewModel.popularMoviesString, width: width, height: height, movies: viewModel.popularMovies, tvShows: nil)
                        HomeSectionsView(viewModel: viewModel, title: viewModel.popularTVShowsString, width: width, height: height, movies: nil, tvShows: viewModel.popularTVShows)
                        HomeSectionsView(viewModel: viewModel, title: viewModel.upcomingMoviesString, width: width, height: height, movies: viewModel.upcomingMovies, tvShows: nil)
                        HomeSectionsView(viewModel: viewModel, title: viewModel.topRatedMoviesString, width: width, height: height, movies: viewModel.topRatedMovies, tvShows: nil)
                        HomeSectionsView(viewModel: viewModel, title: viewModel.onTheAirTVShowsString, width: width, height: height, movies: nil, tvShows: viewModel.onTheAirTVShows)
                        HomeSectionsView(viewModel: viewModel, title: viewModel.topRatedTVShowsString, width: width, height: height, movies: nil, tvShows: viewModel.topRatedTVShows)
                    }
                }
                .navigationTitle("Home")
                .refreshable {
                    Task {
                        await viewModel.fetchMoviesAndTVShows()
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMoviesAndTVShows()
                }
            }
        }
    }
}
