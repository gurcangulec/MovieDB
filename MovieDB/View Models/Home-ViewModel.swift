////
////  Home-ViewModel.swift
////  MovieDB
////
////  Created by Gürcan Güleç on 17.01.2023.
////
//
//import Foundation
//import SwiftUI
//
//extension Home {
//    @MainActor
//    class ViewModel: ObservableObject {
//        
//        var width: Double = 0.0
//        var height: Double = 0.0
//
//        let url = "https://image.tmdb.org/t/p/original/"
//        
//        // Strings for nagivation title
//        let popularMoviesString = "Popular Movies"
//        let upcomingMoviesString = "Upcoming Movies"
//        let popularTVShowsString = "Popular TV Shows"
//        let topRatedMoviesString = "Top Rated Movies"
//        let topRatedTVShowsString = "Top Rated TV Shows"
//        let onTheAirTVShowsString = "On The Air"
//        
//        // Arrays for movies and TV shows
//        @Published var popularMovies = [Movie]()
//        @Published var upcomingMovies = [Movie]()
//        @Published var popularTVShows = [TVShow]()
//        @Published var topRatedMovies = [Movie]()
//        @Published var topRatedTVShows = [TVShow]()
//        @Published var onTheAirTVShows = [TVShow]()
//        @Published var sliderMovies = [Movie]()
//        
//        // Function to fetch all the necessary movies and TV shows
//        func fetchTVShowsAndMovies() async {
//            self.popularMovies = await FetchData.downloadPopularMovies()
//            self.upcomingMovies = await FetchData.downloadUpcomingMovies()
//            self.popularTVShows = await FetchData.downloadPopularTVShows()
//            self.topRatedMovies = await FetchData.downloadTopRatedMovies()
//            self.topRatedTVShows = await FetchData.downloadTopRatedTVShows()
//            self.onTheAirTVShows = await FetchData.downloadOnTheAirTVShows()
//            self.sliderMovies = await FetchData.downloadPopularMovies()
//        }
//        
//        func fetchView(movie: [Movie], count: Int, width: Double, height: Double) -> some View {
//            ZStack(alignment: .center) {
//                NavigationLink {
//                    MovieView(movie: movie[count])
//                } label: {
//                    ImageView(urlString: "\(url)\(movie[count].unwrappedBackdropPath)", width: width, height: height)
//                }
//                Text(movie[count].originalTitle)
//                    .font(.caption)
//                    .fontWeight(.black)
//                    .padding(8)
//                    .foregroundColor(.white)
//                    .background(.black.opacity(0.75))
//                    .clipShape(Capsule())
//                    .offset(y: height * 0.4)
//            }
//        }
//        
//        func passWidth(geometry: GeometryProxy) -> EmptyView {
//                self.width = geometry.size.width
//                self.height = geometry.size.height
//                print(width)
//                return EmptyView()
//        }
//    }
//}
