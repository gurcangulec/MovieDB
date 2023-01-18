//
//  Search.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import Kingfisher

struct Search: View {
    @StateObject private var viewModel = ViewModel()
    
//    @State private var toggle = true
    private let url = "https://image.tmdb.org/t/p/original/"
    
    
    var body: some View {
        NavigationView {
            if viewModel.movies.isEmpty || viewModel.tvShows.isEmpty {
                VStack {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title)
                        .padding(.bottom)
                    Text("You haven't searched for anything yet.")
                        .navigationTitle("Search")
                        .font(.footnote)
                }
                .padding(.top, -44)
                .searchable(text: $viewModel.searchQuery,
                            prompt: "Search for a movie")
            } else {
                VStack {
                    if viewModel.pickerVisible == true {
                        Picker("Select category", selection: $viewModel.chosenCategory) {
                            ForEach(viewModel.categories, id:\.self) {
                                Text($0)
                            }
                        }
                        .padding([.leading, .trailing])
                        .padding(.top, 5)
                        .pickerStyle(.segmented)
                    }
                    
                    if viewModel.chosenCategory == "Movie" {
                        List(viewModel.movies) { movie in
                            MovieAndTVShowRow(movie: movie, tvShow: nil)
                        }
                        .listStyle(.plain)
                        .navigationTitle("Search")
                        
                    } else {
                        List(viewModel.tvShows) { tvShow in
                            MovieAndTVShowRow(movie: nil, tvShow: tvShow)
                        }
                        .listStyle(.plain)
                        .navigationTitle("Search")
                        
                    }
                }
                .searchable(text: $viewModel.searchQuery)
            }
        }
        .disableAutocorrection(true)
//        .onAppear {
//            Task {
//                popularMovies = await FetchData.downloadPopularMovies()
//            }
//        }
        .onSubmit(of: .search) {
            Task {
                await viewModel.onSubmitFunc()
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
