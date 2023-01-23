//
//  Search.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import Kingfisher

struct Search: View {
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.searchedMovies.isEmpty || viewModel.searchedTvShows.isEmpty {
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
                        List(viewModel.searchedMovies) { movie in
                            MovieAndTVShowRow(viewModel: viewModel, movie: movie, tvShow: nil)
                        }
                        .listStyle(.plain)
                        .navigationTitle("Search")
                        
                    } else {
                        List(viewModel.searchedTvShows) { tvShow in
                            MovieAndTVShowRow(viewModel: viewModel, movie: nil, tvShow: tvShow)
                        }
                        .listStyle(.plain)
                        .navigationTitle("Search")
                        
                    }
                }
                .searchable(text: $viewModel.searchQuery)
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
        .onSubmit(of: .search) {
            Task {
                await viewModel.searchMoviesAndTVShows()
                viewModel.pickerVisible = true
            }
        }
        .navigationViewStyle(.stack)
    }
}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        Search()
//    }
//}
