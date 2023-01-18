//
//  Search-ViewModel.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 17.01.2023.
//

import Foundation

extension Search {
    @MainActor
    class ViewModel: ObservableObject {
        
        @Published var searchQuery = ""
        
        @Published var movies = [Movie]()
        @Published var tvShows = [TVShow]()
        @Published var popularMovies = [Movie]()
        @Published var cast = [CastMember]()
        
        @Published var categories = ["Movie", "TV Show"]
        @Published var chosenCategory = "Movie"
        @Published var pickerVisible = false
        
        func onSubmitFunc() async {
            movies = await FetchData.downloadMovies(searchQuery: searchQuery)
            tvShows = await FetchData.downloadTVShows(searchQuery: searchQuery)
            pickerVisible = true
        }
        
        
    }
}
