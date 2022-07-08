//
//  MoviesView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import Kingfisher
import ExpandableText

struct MoviesView: View {
    // The movies downloaded from server
    @State private var movies = [Movie]()
    @State private var cast = [CastMember]()
    private let url = "https://image.tmdb.org/t/p/original/"
    @State var searchQuery = ""

    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            List(movies, rowContent: MovieRow.init)
                .listStyle(.plain)
                .navigationTitle("Movies")
        }
        .task {
            movies = await FetchData.downloadPopularMovies()
        }
        .searchable(text: $searchQuery, prompt: "Search for a movie")
        .onSubmit(of: .search) {
            Task {
                movies = await FetchData.downloadMovies(searchQuery: searchQuery)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
