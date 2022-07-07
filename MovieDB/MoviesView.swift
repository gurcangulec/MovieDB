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
            await downloadPopularMovies()
        }
        .searchable(text: $searchQuery, prompt: "Search for a movie")
        .onSubmit(of: .search) {
            Task {
                await downloadMovies()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @Sendable func downloadPopularMovies() async {
            // Check URL
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=c74260965badd03144f9a327f254f0a2&language=en-US&page=1") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(Movies.self, from: data) {
                    movies = decoded.results
                }
            } catch {
                print("Invalid Something")
            }
    }
    
    @Sendable func downloadMovies() async {
            let replaced = searchQuery.replacingOccurrences(of: " ", with: "+").lowercased()
            // Check URL
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=c74260965badd03144f9a327f254f0a2&query=\(replaced)") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoder = JSONDecoder()
                
                // Decode from data
                if let decoded = try? decoder.decode(Movies.self, from: data) {
                    movies = decoded.results
                }
            } catch {
                print("Invalid Something")
            }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
