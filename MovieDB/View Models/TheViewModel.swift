//
//  TheViewModel.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 22.01.2023.
//

import CoreData
import Foundation
import UIKit

@MainActor
class TheViewModel: ObservableObject {
    
    private(set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchWatchlistedMovies()
        fetchRatedMovies()
    }
    
    let imageUrl = "https://image.tmdb.org/t/p/original/"
    
    // MARK: Home
    @Published var popularMovies = [Movie]()
    @Published var upcomingMovies = [Movie]()
    @Published var popularTVShows = [TVShow]()
    @Published var topRatedMovies = [Movie]()
    @Published var topRatedTVShows = [TVShow]()
    @Published var onTheAirTVShows = [TVShow]()
    @Published var sliderMovies = [Movie]()
    
    let popularMoviesString = "Popular Movies"
    let upcomingMoviesString = "Upcoming Movies"
    let popularTVShowsString = "Popular TV Shows"
    let topRatedMoviesString = "Top Rated Movies"
    let topRatedTVShowsString = "Top Rated TV Shows"
    let onTheAirTVShowsString = "On The Air"
    
    func fetchMoviesAndTVShows() async {
        self.popularMovies = await FetchData.downloadPopularMovies()
        self.upcomingMovies = await FetchData.downloadUpcomingMovies()
        self.popularTVShows = await FetchData.downloadPopularTVShows()
        self.topRatedMovies = await FetchData.downloadTopRatedMovies()
        self.topRatedTVShows = await FetchData.downloadTopRatedTVShows()
        self.onTheAirTVShows = await FetchData.downloadOnTheAirTVShows()
        self.sliderMovies = await FetchData.downloadPopularMovies()
    }

    // MARK: Search
    @Published var searchedMovies = [Movie]()
    @Published var searchedTvShows = [TVShow]()
    @Published var cast = [CastMember]()
    
    @Published var categories = ["Movie", "TV Show"]
    @Published var chosenCategory = "Movie"
    @Published var pickerVisible = false
    
    @Published var searchQuery = ""
    
    func searchMoviesAndTVShows() async {
        searchedMovies = await FetchData.downloadMovies(searchQuery: searchQuery)
        searchedTvShows = await FetchData.downloadTVShows(searchQuery: searchQuery)
    }
    
    // MARK: Watchlist
    @Published var watchlistedMovies: [StoredMovie] = []
    
    enum SortedBy: String {
        case title = "Title"
        case dateAdded = "Date Added"
        case releaseDate = "Release Date"
        case rating = "TMBD Rating"
    }
    
    @Published var sortedBy = SortedBy.title
    @Published var sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
    
    func fetchWatchlistedMovies() {
        let request = NSFetchRequest<StoredMovie>(entityName: "StoredMovie")
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "watchlisted == true")
        
        do {
            watchlistedMovies = try context.fetch(request)
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func addToWatchlist(movie: Movie) {
        let watchlistMovie = StoredMovie(context: context)
        watchlistMovie.id = Int32(movie.id)
        watchlistMovie.title = movie.originalTitle
        watchlistMovie.posterPath = movie.posterPath
        watchlistMovie.releaseDate = movie.formattedReleaseDateForStorage
        watchlistMovie.overview = movie.overview
        watchlistMovie.dateAdded = Date.now
        watchlistMovie.rating = movie.voteAverage
        watchlistMovie.backdropPath = movie.backdropPath
        watchlistMovie.watchlisted = true
        print("Saving")
        saveData()
    }
    
    func saveData() {
        do {
            try context.save()
            fetchWatchlistedMovies()
            fetchRatedMovies()
        } catch let error {
            print("Error saving: \(error)")
        }
    }
    
    // MARK: RatingsList
    
    @Published var ratedMovies: [StoredMovie] = []
    
    func fetchRatedMovies() {
        let request = NSFetchRequest<StoredMovie>(entityName: "StoredMovie")
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "rated == true")
        
        do {
            ratedMovies = try context.fetch(request)
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func addToRated(movie: Movie, rating: Int) {
        let ratedMovie = StoredMovie(context: context)
        ratedMovie.id = Int32(movie.id)
        ratedMovie.title = movie.originalTitle
        ratedMovie.posterPath = movie.posterPath
        ratedMovie.releaseDate = movie.formattedReleaseDateForStorage
        ratedMovie.overview = movie.overview
        ratedMovie.dateAdded = Date.now
        ratedMovie.rating = movie.voteAverage
        ratedMovie.backdropPath = movie.backdropPath
        ratedMovie.rated = true
        ratedMovie.userRating = Int16(rating)
        print("Saving")
        saveData()
    }
    
    // MARK: MovieView
    @Published var showingSheetWatchlist = false
    @Published var showingSheetRating = false
    @Published var watchlistButtonText = "Add to Watchlist"
    
    @Published var movieDetails = MovieDetails()
//    @Published var cast = [CastMember]()
    @Published var crew = [CrewMember]()
    
    var writers: [String] {
        var writtenByArray = [String]()
        var storyByArray = [String]()
        var screenplayByArray = [String]()
        
        for member in crew {
            if member.job == "Writer" {
                let addToArray = "\(member.originalName) (written by)"
                writtenByArray.append(addToArray)
            } else if member.job == "Story" {
                let addToArray = "\(member.originalName) (story by)"
                storyByArray.append(addToArray)
            } else if member.job == "Screenplay" {
                let addToArray = "\(member.originalName) (screenplay by)"
                screenplayByArray.append(addToArray)
            }
        }
        
        return writtenByArray + storyByArray + screenplayByArray
    }
    
    func fetchCastAndCrew(movieId: Int) async {
        cast = await FetchData.downloadCast(movieId: movieId)
        crew = await FetchData.downloadCrew(movieId: movieId)
        movieDetails = await FetchData.downloadSpecificMovie(movieId: movieId)
    }
    
    func fetchCastAndCrewTVShow(tvShowId: Int) async {
        cast = await FetchData.downloadCastTVShow(tvShowId: tvShowId)
        crew = await FetchData.downloadCrewTVShow(tvShowId: tvShowId)
    }
    
    func copyToClipboard(movie: Movie?, tvShow: TVShow?) {
        if let movie {
            UIPasteboard.general.string = "https://www.themoviedb.org/movie/\(movie.id)"
        }
        if let tvShow {
            UIPasteboard.general.string = "https://www.themoviedb.org/tv/\(tvShow.id)"
        }
    }
    
    func copyToClipboardIMDB() {
        UIPasteboard.general.string = "https://www.imdb.com/title/\(movieDetails.unwrappedImdbId)"
    }
    
    func shareButton(movie: Movie?, tvShow: TVShow?) {
        if let movie {
            let activityController = UIActivityViewController(activityItems: ["https://www.themoviedb.org/movie/\(movie.id)"], applicationActivities: nil)
            
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            
            window?.rootViewController!.present(activityController, animated: true, completion: nil)
        }
        
        if let tvShow {
            let activityController = UIActivityViewController(activityItems: ["https://www.themoviedb.org/tv/\(tvShow.id)"], applicationActivities: nil)
            
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            
            window?.rootViewController!.present(activityController, animated: true, completion: nil)
        }
    }
    func shareImdbButton() {

        let activityController = UIActivityViewController(activityItems: ["https://www.imdb.com/title/\(movieDetails.unwrappedImdbId)"], applicationActivities: nil)

        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first

        window?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}
