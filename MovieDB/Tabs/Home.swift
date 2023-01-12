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
    
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Text("Popular Movies")
                                .font(.title2.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, geo.size.height * 0.001)
                                .padding(.leading, 15)
                            SideScroller(tvShows: nil, movies: popularMovies, cast: nil, crew: nil, url: url, geoWidth: geo.size.width)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Upcoming Movies")
                                .font(.title2.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, geo.size.height * 0.001)
                                .padding(.leading, 15)
                            SideScroller(tvShows: nil, movies: upcomingMovies, cast: nil, crew: nil, url: url, geoWidth: geo.size.width)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Popular TV Shows")
                                .font(.title2.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, geo.size.height * 0.001)
                                .padding(.leading, 15)
                            SideScroller(tvShows: popularTVShows, movies: nil, cast: nil, crew: nil, url: url, geoWidth: geo.size.width)
                        }

                        VStack(alignment: .leading) {
                            Text("Top Rated Movies")
                                .font(.title2.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, geo.size.height * 0.001)
                                .padding(.leading, 15)
                            SideScroller(tvShows: nil, movies: topRatedMovies, cast: nil, crew: nil, url: url, geoWidth: geo.size.width)
                        }

                        VStack(alignment: .leading) {
                            Text("Top Rated TV Shows")
                                .font(.title2.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, geo.size.height * 0.001)
                                .padding(.leading, 15)
                            SideScroller(tvShows: topRatedTVShows, movies: nil, cast: nil, crew: nil, url: url, geoWidth: geo.size.width)
                        }
                    }
                }
//                .padding(.leading, 10)
                .navigationTitle("MovieDB")
            }
            .onAppear {
                Task {
                    popularMovies = await FetchData.downloadPopularMovies()
                    upcomingMovies = await FetchData.downloadUpcomingMovies()
                    popularTVShows = await FetchData.downloadPopularTVShows()
                    topRatedMovies = await FetchData.downloadTopRatedMovies()
                    topRatedTVShows = await FetchData.downloadTopRatedTVShows()
                }
            }
        }
    }
}
