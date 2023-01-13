//
//  Home.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import SwiftUI

struct Home: View {
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
                        HomeSectionsView(title: popularMoviesString, width: width, height: height, movies: popularMovies, tvShows: nil)
                        HomeSectionsView(title: popularTVShowsString, width: width, height: height, movies: nil, tvShows: popularTVShows)
                        HomeSectionsView(title: upcomingMoviesString, width: width, height: height, movies: upcomingMovies, tvShows: nil)
                        HomeSectionsView(title: topRatedMoviesString, width: width, height: height, movies: topRatedMovies, tvShows: nil)
                        HomeSectionsView(title: onTheAirTVShowsString, width: width, height: height, movies: nil, tvShows: onTheAirTVShows)
                        HomeSectionsView(title: topRatedTVShowsString, width: width, height: height, movies: nil, tvShows: topRatedTVShows)
                    }
                }
                .navigationTitle("Home")
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
}
