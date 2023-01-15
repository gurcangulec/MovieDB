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

    
    @State private var popularMovies = [Movie]()
    @State private var upcomingMovies = [Movie]()
    @State private var popularTVShows = [TVShow]()
    @State private var topRatedMovies = [Movie]()
    @State private var topRatedTVShows = [TVShow]()
    @State private var onTheAirTVShows = [TVShow]()
    
    private let popularMoviesString = "Popular Movies"
    private let upcomingMoviesString = "Upcoming Movies"
    private let popularTVShowsString = "Popular TV Shows"
    private let topRatedMoviesString = "Top Rated Movies"
    private let topRatedTVShowsString = "Top Rated TV Shows"
    private let onTheAirTVShowsString = "On The Air"
    
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            
            let width = geo.size.width
            let height = geo.size.height * 0.001
            
            NavigationView {
                VStack {
                    
                    ScrollView(showsIndicators: false) {
                        // Foreground
                        TabView{
                            ForEach(popularMovies.indices, id: \.self) { index in
                                fetchView(count: count, width: width * 0.97, height: geo.size.height * 0.3)
//                                ZStack(alignment: .center) {
//                                    NavigationLink {
//                                        MovieView(movie: popularMovies[index])
//                                    } label: {
//                                        ImageView(urlString: "\(url)\(popularMovies[index].unwrappedBackdropPath)", width: width * 0.97, height: geo.size.height * 0.3)
//                                    }
//                                    Text(popularMovies[index].originalTitle)
//                                        .font(.caption)
//                                        .fontWeight(.black)
//                                        .padding(8)
//                                        .foregroundColor(.white)
//                                        .background(.black.opacity(0.75))
//                                        .clipShape(Capsule())
//                                        .offset(y: 85)
//                                }
//                                .tag(index)
                                
                            }
                            
//                          Rectangle()
//                            .foregroundColor(.red)
//                            .tag(1)
//                          Rectangle()
//                            .foregroundColor(.blue)
//                            .tag(2)
//                          Rectangle()
//                            .foregroundColor(.green)
//                            .tag(3)
//                          Rectangle()
//                            .foregroundColor(.orange)
//                            .tag(4)
//                          Rectangle()
//                            .foregroundColor(.pink)
//                            .tag(5)
                        } //: TAB
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: geo.size.height * 0.3)
                        
                        Divider()
                        
                        HomeSectionsView(title: popularMoviesString, width: width, height: height, movies: popularMovies, tvShows: nil)
                        HomeSectionsView(title: popularTVShowsString, width: width, height: height, movies: nil, tvShows: popularTVShows)
                        HomeSectionsView(title: upcomingMoviesString, width: width, height: height, movies: upcomingMovies, tvShows: nil)
                        HomeSectionsView(title: topRatedMoviesString, width: width, height: height, movies: topRatedMovies, tvShows: nil)
                        HomeSectionsView(title: onTheAirTVShowsString, width: width, height: height, movies: nil, tvShows: onTheAirTVShows)
                        HomeSectionsView(title: topRatedTVShowsString, width: width, height: height, movies: nil, tvShows: topRatedTVShows)
                    }
                }
                .navigationTitle("Home")
                .refreshable {
                    Task {
                        popularMovies = await FetchData.downloadPopularMovies()
                        upcomingMovies = await FetchData.downloadUpcomingMovies()
                        popularTVShows = await FetchData.downloadPopularTVShows()
                        topRatedMovies = await FetchData.downloadTopRatedMovies()
                        topRatedTVShows = await FetchData.downloadTopRatedTVShows()
                        onTheAirTVShows = await FetchData.downloadOnTheAirTVShows()
                    }
                }
            }
            .onReceive(timer) { _ in
                withAnimation {
                    count = count == 5 ? 1 : count + 1
                }
            }
            .onAppear {
                Task {
                    popularMovies = await FetchData.downloadPopularMovies()
                    upcomingMovies = await FetchData.downloadUpcomingMovies()
                    popularTVShows = await FetchData.downloadPopularTVShows()
                    topRatedMovies = await FetchData.downloadTopRatedMovies()
                    topRatedTVShows = await FetchData.downloadTopRatedTVShows()
                    onTheAirTVShows = await FetchData.downloadOnTheAirTVShows()
                }
            }
        }
    }
    @ViewBuilder
    func fetchView(count: Int, width: Double, height: Double) -> some View {
        ZStack(alignment: .center) {
            NavigationLink {
                MovieView(movie: popularMovies[count])
            } label: {
                ImageView(urlString: "\(url)\(popularMovies[count].unwrappedBackdropPath)", width: width, height: height)
            }
            Text(popularMovies[count].originalTitle)
                .font(.caption)
                .fontWeight(.black)
                .padding(8)
                .foregroundColor(.white)
                .background(.black.opacity(0.75))
                .clipShape(Capsule())
                .offset(y: 85)
        }
        .tag(count)
    }
}
