//
//  MovieView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 06.07.2022.
//

import CoreHaptics
import SwiftUI
import Kingfisher

struct MovieView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var watchlistMovies: FetchedResults<WatchlistMovie>
    
//    @State private var engine: CHHapticEngine?
    @StateObject var hapticEngine = Haptics()
    
    @State private var showingSheetWatchlist = false
    @State private var showingSheetRating = false
    @State private var watchlistButtonText = "Add to Watchlist"
    
    let movie: Movie
    @State private var movieDetails = MovieDetails()
    @State private var cast = [CastMember]()
    @State private var crew = [CrewMember]()
    private let url = "https://image.tmdb.org/t/p/original/"
    
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
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    if let unwrappedPath = movie.backdropPath {
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
                            Text(movie.originalTitle)
                                .font(.title.weight(.semibold))
                                .padding(.bottom, geo.size.height * 0.01)
                            
                            HStack {
                                Image(systemName: "star.fill")
                                Text("\(movie.convertToString)/10")
                                    .font(.body)
                                
                                Spacer()
                                
                                Image(systemName: "calendar")
                                Text("\(movie.formattedReleaseDate)")
                                    .font(.body)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            .padding(.bottom, geo.size.height * 0.01)
                            
                            Text(movie.overview)
                                .font(.body)
                                .padding(.bottom, geo.size.height * 0.01)
                            
                            HStack {
                                Button {
                                    showingSheetWatchlist.toggle()
                                    
                                    do {
                                        try moc.save()
                                    } catch {
                                        print("Something went wrong while saving: \(error.localizedDescription)")
                                    }
                                    
                                    hapticEngine.complexSuccess()
                                    
                                } label: {
                                    Label("Watchlist", systemImage: "plus")
                                        .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                }
                                .buttonStyle(.bordered)
                                
                                Button {
                                    showingSheetRating.toggle()
                                    //                                let watchlistMovie = WatchlistMovie(context: moc)
                                    //                                watchlistMovie.id = UUID()
                                    //                                watchlistMovie.title = movie.originalTitle
                                    //                                watchlistMovie.posterPath = movie.posterPath
                                    //                                watchlistMovie.formattedReleaseDate = movie.formattedReleaseDate
                                    //                                watchlistMovie.overview = movie.overview
                                    //                                watchlistMovie.dateAdded = Date.now
                                    //                                watchlistMovie.rating = movie.voteAverage
                                    
                                    
                                    
                                    hapticEngine.complexSuccess()
                                    
                                } label: {
                                    Label("Rate", systemImage: "star.fill")
                                        .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .sheet(isPresented: $showingSheetWatchlist) {
                            AddToWatchlistView(movie: movie, width: geo.size.width * 0.54, height: geo.size.width * 0.81)
                        }
                        .sheet(isPresented: $showingSheetRating, content: {
                            AddRatingView(movie: movie, width: geo.size.width * 0.54, height: geo.size.width * 0.81)
                        })
//                        .onAppear(perform: checkIfAdded)
                        .onAppear(perform: hapticEngine.prepareHaptics)
                        
                        Divider()
                        
                        HStack {
                            Text("Cast")
                                .font(.title2.weight(.semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, geo.size.height * 0.001)
                            
                            NavigationLink {
                                FullCrewView(movie: movie, cast: cast, crew: crew)
                            } label: {
                                Text("Full Cast & Crew")
                                
                                Image(systemName: "chevron.right")
                            }
//                            .padding(.bottom)
                        }
                        
                        SideScroller(tvShows: nil, movies: nil, cast: cast, crew: nil, url: url, geoWidth: geo.size.width)
                        
                        Divider()
                        
                        Group {
                            VStack {
                                Text("Director(s)")
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, geo.size.height * 0.001)
                                
                                ForEach(crew) { crewMember in
                                    if crewMember.job == "Director" {
                                        Text(crewMember.originalName)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.bottom, geo.size.height * 0.01)
                                    }
                                }
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Writer(s)")
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, geo.size.height * 0.001)
                            }
                            
                            ForEach(writers, id:\.self) { writer in
                                    Text(writer)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, geo.size.height * 0.01)
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    .task {
                        cast = await FetchData.downloadCast(movieId: movie.id)
                        crew = await FetchData.downloadCrew(movieId: movie.id)
                        movieDetails = await FetchData.downloadSpecificMovie(movieId: movie.id)
                    }
                    .refreshable {
                        cast = await FetchData.downloadCast(movieId: movie.id)
                        crew = await FetchData.downloadCrew(movieId: movie.id)
                        movieDetails = await FetchData.downloadSpecificMovie(movieId: movie.id)
                    }
                }
            }
            .navigationTitle(movie.originalTitle)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu {
                Menu("Copy Link") {
                    Button {
                        copyToClipboard()
                    } label: {
                        Label("Copy TMDB Link", systemImage: "link")
                    }
                    
                    Button {
                        copyToClipboardIMDB()
                    } label: {
                        Label("Copy IMDB Link", systemImage: "link")
                    }
                }
                
                Menu("Share") {
                    Button {
                        shareButton()
                    } label: {
                        Label("Share TMBD Link", systemImage: "square.and.arrow.up")
                    }
                    
                    Button {
                        shareImdbButton()
                    } label: {
                        Label("Share IMDB Link", systemImage: "square.and.arrow.up")
                    }
                }
                
                Button {
                    print("Add to Watchlist")
                } label: {
                    Label("Add to Watchlist", systemImage: "play.circle.fill")
                }
                
            } label: {
                Label("Options", systemImage: "ellipsis")
            }
            .onAppear(perform: hapticEngine.prepareHaptics)
            .onTapGesture(perform: hapticEngine.complexSuccess)
        }
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = "https://www.themoviedb.org/movie/\(movie.id)"
    }
    
    func copyToClipboardIMDB() {
        UIPasteboard.general.string = "https://www.imdb.com/title/\(movieDetails.unwrappedImdbId)"
    }
    
//    func checkIfAdded() {
//        for watchlistMovie in watchlistMovies {
//            if watchlistMovie.title == movie.originalTitle {
//                watchlistButtonText = "Added to Watchlist"
//            } else {
//                watchlistButtonText = "Add to Watchlist"
//            }
//        }
//    }
    
    // To be moved from here
    func addToWatchlist() { }
    func shareButton() {
        
        let activityController = UIActivityViewController(activityItems: ["https://www.themoviedb.org/movie/\(movie.id)"], applicationActivities: nil)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        window?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    func shareImdbButton() {
        
        let activityController = UIActivityViewController(activityItems: ["https://www.imdb.com/title/\(movieDetails.unwrappedImdbId)"], applicationActivities: nil)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        window?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: .example)
    }
}
