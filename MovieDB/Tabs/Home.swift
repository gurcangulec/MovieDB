//
//  Home.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import SwiftUI

struct Home: View {
    @State private var popularMovies = [Movie]()
    @State private var toggle = true
    
    var body: some View {
        NavigationView {
            List(popularMovies, rowContent: MovieRow.init)
                .listStyle(.plain)
                .navigationTitle("Popular Movies")
        }
        .task {
            popularMovies = await FetchData.downloadPopularMovies()
        }
    }
}
