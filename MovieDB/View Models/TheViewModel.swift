//
//  TheViewModel.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 22.01.2023.
//

import CoreData
import Foundation

@MainActor
class TheViewModel: ObservableObject {
    
    private(set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchWatchlistedMovies()
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
    
    let request = NSFetchRequest<StoredMovie>(entityName: "StoredMovie")
//    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    
    func fetchWatchlistedMovies() {
        
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        request.predicate = NSPredicate(format: "watchlisted == true")
        
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
        } catch let error {
            print("Error saving: \(error)")
        }
    }
    
    // MARK: MovieView
    @Published var showingSheetWatchlist = false
    @Published var showingSheetRating = false
    @Published var watchlistButtonText = "Add to Watchlist"
    
    @Published var movieDetails = MovieDetails()
//    @Published var cast = [CastMember]()
    @Published var crew = [CrewMember]()
    
    func fetchCastAndCrew(movieId: Int) async {
        cast = await FetchData.downloadCast(movieId: movieId)
        crew = await FetchData.downloadCrew(movieId: movieId)
        movieDetails = await FetchData.downloadSpecificMovie(movieId: movieId)
    }
    
}
