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
    @State private var cast = [CastMember]()
    @State private var toggle = true
    private let url = "https://image.tmdb.org/t/p/original/"
    @State var searchQuery = ""
    
    var body: some View {
        NavigationView {
            List(movies, rowContent: MovieRow.init)
                .listStyle(.plain)
                .navigationTitle("MovieDB")
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

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
