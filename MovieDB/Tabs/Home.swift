//
//  Home.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import SwiftUI

struct Home: View {
    // MARK: -  PROPERTY
    let timer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    // Animation counter
    @State var count: Int = 1

    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            
            let width = geo.size.width
            let height = geo.size.height * 0.001
            
            NavigationView {
                VStack {
                    ScrollView(showsIndicators: false) {
                        TabView{
                            ForEach(viewModel.sliderMovies.indices, id: \.self) { index in
                                viewModel.fetchView(movie: viewModel.popularMovies, count: count, width: width * 0.97, height: geo.size.height * 0.3)
                                    .tag(count)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: geo.size.height * 0.3)
                        
                        Divider()
                        
                        HomeSectionsView(title: viewModel.popularMoviesString, width: width, height: height, movies: viewModel.popularMovies, tvShows: nil)
                        HomeSectionsView(title: viewModel.popularTVShowsString, width: width, height: height, movies: nil, tvShows: viewModel.popularTVShows)
                        HomeSectionsView(title: viewModel.upcomingMoviesString, width: width, height: height, movies: viewModel.upcomingMovies, tvShows: nil)
                        HomeSectionsView(title: viewModel.topRatedMoviesString, width: width, height: height, movies: viewModel.topRatedMovies, tvShows: nil)
                        HomeSectionsView(title: viewModel.onTheAirTVShowsString, width: width, height: height, movies: nil, tvShows: viewModel.onTheAirTVShows)
                        HomeSectionsView(title: viewModel.topRatedTVShowsString, width: width, height: height, movies: nil, tvShows: viewModel.topRatedTVShows)
                    }
                }
                .navigationTitle("Home")
                .refreshable {
                    Task {
                        await viewModel.fetchTVShowsAndMovies()
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchTVShowsAndMovies()
                }
            }
            .onReceive(timer) { _ in
                withAnimation {
                    count = count == 5 ? 1 : count + 1
                }
            }
        }
    }
}
