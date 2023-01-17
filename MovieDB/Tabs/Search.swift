//
//  Search.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import Kingfisher

struct Search: View {
    // The movies downloaded from server
    @State private var movies = [Movie]()
    @State private var tvShows = [TVShow]()
    @State private var popularMovies = [Movie]()
    @State private var cast = [CastMember]()
    
    @State private var categories = ["Movie", "TV Show"]
    @State private var chosenCategory = "Movie"
    @State private var pickerVisible = false
    
//    @State private var toggle = true
    private let url = "https://image.tmdb.org/t/p/original/"
    @State var searchQuery = ""
    
    var body: some View {
        NavigationView {
            if movies.isEmpty || tvShows.isEmpty {
                VStack {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title)
                        .padding(.bottom)
                    Text("You haven't searched for anything yet.")
                        .navigationTitle("Search")
                        .font(.footnote)
                }
                .padding(.top, -44)
                .searchable(text: $searchQuery,
                            prompt: "Search for a movie")
            } else {
                VStack {
                    if pickerVisible == true {
                        Picker("Select category", selection: $chosenCategory) {
                            ForEach(categories, id:\.self) {
                                Text($0)
                            }
                        }
                        .padding([.leading, .trailing])
                        .padding(.top, 5)
                        .pickerStyle(.segmented)
                    }
                    
                    if chosenCategory == "Movie" {
                        List(movies) { movie in
                            MovieAndTVShowRow(movie: movie, tvShow: nil)
                        }
                        .listStyle(.plain)
                        .navigationTitle("Search")
                        
                    } else {
                        List(tvShows) { tvShow in
                            MovieAndTVShowRow(movie: nil, tvShow: tvShow)
                        }
                        .listStyle(.plain)
                        .navigationTitle("Search")
                        
                    }
                }
                .searchable(text: $searchQuery)
            }
            
            //                        suggestions: {
            //                Text("Some suggestions")
            //                    .font(.title2)
            //                    .foregroundColor(.primary)
            //
            //                ForEach(popularMovies.prefix(3)) { popularMovie in
            //                    Text(popularMovie.originalTitle).searchCompletion("\(popularMovie.originalTitle)")
            //                        .font(.body)
            //                }
            //            })
        }
        .disableAutocorrection(true)
        .onAppear {
            Task {
                popularMovies = await FetchData.downloadPopularMovies()
            }
        }
        .onSubmit(of: .search) {
            Task {
                movies = await FetchData.downloadMovies(searchQuery: searchQuery)
                tvShows = await FetchData.downloadTVShows(searchQuery: searchQuery)
                pickerVisible = true
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
