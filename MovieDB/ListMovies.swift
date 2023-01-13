//
//  ListMovies.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import SwiftUI

struct AllPopular: View {
    let movies: [Movie]?
    let tvShows: [TVShow]?
    let navTitle: String
    
    var body: some View {
        if let movies = movies {
            List(movies) { movie in
                MovieAndTVShowRow(movie: movie, tvShow: nil)
            }
            .listStyle(.plain)
            .navigationTitle("\(navTitle)")
        } else {
            if let tvShows = tvShows {
                List(tvShows) { tvShow in
                    MovieAndTVShowRow(movie: nil, tvShow: tvShow)
                }
                .listStyle(.plain)
                .navigationTitle("\(navTitle)")
            }
        }
    }
}

//struct AllPopular_Previews: PreviewProvider {
//    static var previews: some View {
//        AllPopular()
//    }
//}
