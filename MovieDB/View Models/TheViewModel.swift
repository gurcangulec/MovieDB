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
    
    let httpClient = HTTPClient()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchWatchlistedMovies()
        fetchRatedMovies()
    }
    
    // MARK: Home
    @Published var popularMovies = [Movie]()
    @Published var upcomingMovies = [Movie]()
    @Published var popularTVShows = [TVShow]()
    @Published var topRatedMovies = [Movie]()
    @Published var topRatedTVShows = [TVShow]()
    @Published var onTheAirTVShows = [TVShow]()
    
    let popularMoviesString = "Popular Movies"
    let upcomingMoviesString = "Upcoming Movies"
    let popularTVShowsString = "Popular TV Shows"
    let topRatedMoviesString = "Top Rated Movies"
    let topRatedTVShowsString = "Top Rated TV Shows"
    let onTheAirTVShowsString = "On The Air"
    
    func fetchMovies() async {
        
        do {
            let decodedPopular = try await httpClient.fetchData(of: Movies.self, Resource(url: URL.popularMovies))
            self.popularMovies = decodedPopular.results
            
            let decodedUpcoming = try await httpClient.fetchData(of: Movies.self, Resource(url: URL.upcomingMovies))
            self.upcomingMovies = decodedUpcoming.results
            
            let decodedTopRated = try await httpClient.fetchData(of: Movies.self, Resource(url: URL.topRatedMovies))
            self.topRatedMovies = decodedTopRated.results
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTVShows() async {
        
        do {
            let decodedPopular = try await httpClient.fetchData(of: TVShows.self, Resource(url: URL.popularTVShows))
            self.popularTVShows = decodedPopular.results
            
            let decodedUpcoming = try await httpClient.fetchData(of: TVShows.self, Resource(url: URL.onTheAirTVShows))
            self.onTheAirTVShows = decodedUpcoming.results
            
            let decodedTopRated = try await httpClient.fetchData(of: TVShows.self, Resource(url: URL.topRatedTVShows))
            self.topRatedTVShows = decodedTopRated.results
        } catch {
            print(error.localizedDescription)
        }
        
    }

    // MARK: Search
    @Published var searchedMovies = [Movie]()
    @Published var searchedTvShows = [TVShow]()
    @Published var cast = [CastMember]()
    
    @Published var categories = ["Movie", "TV Show"]
    @Published var chosenCategory = "Movie"
    @Published var pickerVisible = false
    
    @Published var searchQuery = ""
    
    func searchMoviesAndTVShows(searchQuery: String) async {
        
        do {
            let decodedSearchedMovies = try await httpClient.fetchData(of: Movies.self, Resource(url: URL.forMoviesByName(searchQuery)))
            searchedMovies = decodedSearchedMovies.results
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let decodedSearchedTVShows = try await httpClient.fetchData(of: TVShows.self, Resource(url: URL.forTVShowsbyName(searchQuery)))
            searchedTvShows = decodedSearchedTVShows.results
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Watchlist
    @Published var watchlistedMovies: [WatchlistedMovieEntity] = []
    
    enum SortedBy: String {
        case titleAToZ = "Title (A - Z)"
        case titleZToA = "Title (Z - A)"
        case dateAddedNewToOld = "Date Added (Newest to Oldest)"
        case dateAddedOldToNew = "Date Added (Oldest to Newest)"
        case releaseDateNewToOld = "Release Date (Newest to Oldest)"
        case releaseDateOldToNew = "Release Date (Oldest to Newest)"
        case ratingHighToLow = "TMBD Rating (Highest to Lowest)"
        case ratingLowToHigh = "TMDB Rating (Lowest to Highest)"
        case userRatingHighToLow = "User Rating (Highest to Lowest)"
        case userRatingLowToHigh = "User Rating (Lowest to Highest)"
    }
    
    @Published var sortedBy = SortedBy.titleAToZ
    @Published var sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
    
    func fetchWatchlistedMovie(movie: Movie) -> Bool {
        return watchlistedMovies.contains(where: { $0.id == movie.id })
    }
    
    func fetchWatchlistedTVShow(tvShow: TVShow) -> Bool {
        return watchlistedMovies.contains(where: { $0.id == tvShow.id })
    }
    
    func fetchWatchlistedMovies() {
        let request = NSFetchRequest<WatchlistedMovieEntity>(entityName: "WatchlistedMovieEntity")
        request.sortDescriptors = [sortDescriptor]
        
        do {
            watchlistedMovies = try context.fetch(request)
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func addToWatchlist(movie: Movie?, tvshow: TVShow?, notes: String) {
        if let movie {
            let watchlistMovie = WatchlistedMovieEntity(context: context)
            watchlistMovie.id = Int32(movie.id)
            watchlistMovie.title = movie.title
            watchlistMovie.posterPath = movie.posterPath
            watchlistMovie.releaseDate = movie.formattedReleaseDateForStorage
            watchlistMovie.overview = movie.overview
            watchlistMovie.dateAdded = Date.now
            watchlistMovie.rating = movie.voteAverage
            watchlistMovie.backdropPath = movie.backdropPath
            watchlistMovie.watchlisted = true
            watchlistMovie.notes = notes
            watchlistMovie.tvShow = false
            saveData()
        }
        if let tvshow {
            let watchlistMovie = WatchlistedMovieEntity(context: context)
            watchlistMovie.id = Int32(tvshow.id)
            watchlistMovie.title = tvshow.originalTitle
            watchlistMovie.posterPath = tvshow.posterPath
            watchlistMovie.releaseDate = tvshow.formattedReleaseDateForStorage
            watchlistMovie.overview = tvshow.overview
            watchlistMovie.dateAdded = Date.now
            watchlistMovie.rating = tvshow.voteAverage
            watchlistMovie.backdropPath = tvshow.backdropPath
            watchlistMovie.watchlisted = true
            watchlistMovie.notes = notes
            watchlistMovie.tvShow = true
            saveData()
        }
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
    
    @Published var ratedMovies: [RatedMovieEntity] = []
    
    func fetchRatedMovie(movie: Movie) -> Bool {
        return ratedMovies.contains(where: { $0.id == movie.id })
    }
    
    func fetchRatedTVShow(tvShow: TVShow) -> Bool {
        return ratedMovies.contains(where: { $0.id == tvShow.id })
    }
    
    func fetchRatedMovies() {
        let request = NSFetchRequest<RatedMovieEntity>(entityName: "RatedMovieEntity")
        request.sortDescriptors = [sortDescriptor]
        
        do {
            ratedMovies = try context.fetch(request)
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func addToRated(movie: Movie?, tvshow: TVShow?, rating: Int) {
        if let movie {
            let ratedMovie = RatedMovieEntity(context: context)
            ratedMovie.id = Int32(movie.id)
            ratedMovie.title = movie.title
            ratedMovie.posterPath = movie.posterPath
            ratedMovie.releaseDate = movie.formattedReleaseDateForStorage
            ratedMovie.overview = movie.overview
            ratedMovie.dateAdded = Date.now
            ratedMovie.rating = movie.voteAverage
            ratedMovie.backdropPath = movie.backdropPath
            ratedMovie.rated = true
            ratedMovie.userRating = Int16(rating)
            ratedMovie.tvShow = false
            saveData()
        }
        
        if let tvshow {
            let ratedMovie = RatedMovieEntity(context: context)
            ratedMovie.id = Int32(tvshow.id)
            ratedMovie.title = tvshow.originalTitle
            ratedMovie.posterPath = tvshow.posterPath
            ratedMovie.releaseDate = tvshow.formattedReleaseDateForStorage
            ratedMovie.overview = tvshow.overview
            ratedMovie.dateAdded = Date.now
            ratedMovie.rating = tvshow.voteAverage
            ratedMovie.backdropPath = tvshow.backdropPath
            ratedMovie.rated = true
            ratedMovie.userRating = Int16(rating)
            ratedMovie.tvShow = true
            saveData()
        }
    }
    
    // MARK: MovieView
    @Published var showingSheetWatchlist = false
    @Published var showingSheetRating = false
    @Published var watchlistButtonText = "Add to Watchlist"
    
    @Published var movieDetails = MovieDetails()
    @Published var tvShowDetails = TVShowDetails(id: 0, createdBy: [], numberOfEpisodes: 0)
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
        
        do {
            let decodedMovieCrew = try await httpClient.fetchData(of: Crew.self, Resource(url: URL.forMovieCastAndCrew(movieId: movieId)))
            crew = decodedMovieCrew.results
            let decodedMovieCast = try await httpClient.fetchData(of: Cast.self, Resource(url: URL.forMovieCastAndCrew(movieId: movieId)))
            cast = decodedMovieCast.results
        } catch {
            print(error.localizedDescription)
        }
 
        movieDetails = await HTTPClient.downloadSpecificMovie(movieId: movieId)
    }
    
    func fetchCastAndCrewTVShow(tvShowId: Int) async {
        cast = await HTTPClient.downloadCastTVShow(tvShowId: tvShowId)
        crew = await HTTPClient.downloadCrewTVShow(tvShowId: tvShowId)
        tvShowDetails = await HTTPClient.downloadSpecificTVShow(tvShowId: tvShowId)
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
