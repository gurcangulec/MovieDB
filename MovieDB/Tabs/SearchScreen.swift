//
//  SearchScreen.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import Kingfisher

struct SearchScreen: View {
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        NavigationView {
            if !viewModel.searchedMovies.isEmpty || !viewModel.searchedTvShows.isEmpty {
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
                        if viewModel.searchedMovies.isEmpty {
                            Spacer()
                            VStack {
                                Image(systemName: "magnifyingglass.circle")
                                    .font(.title)
                                    .padding(.bottom)
                                Text("No movies found with this title.")
                                    .navigationTitle("Search")
                                    .font(.footnote)
                            }
                            Spacer()
//                            .padding(.top, -44)
                        } else {
                            List(viewModel.searchedMovies) { movie in
                                MovieAndTVShowRow(viewModel: viewModel, movie: movie, tvShow: nil)
                            }
                            .listStyle(.plain)
                            .navigationTitle("Search")
                        }
            
                    } else {
                        if viewModel.searchedTvShows.isEmpty {
                            Spacer()
                            VStack {
                                Image(systemName: "magnifyingglass.circle")
                                    .font(.title)
                                    .padding(.bottom)
                                Text("No TV shows found with this title.")
                                    .navigationTitle("Search")
                                    .font(.footnote)
                            }
                            Spacer()
                        } else {
                            List(viewModel.searchedTvShows) { tvShow in
                                MovieAndTVShowRow(viewModel: viewModel, movie: nil, tvShow: tvShow)
                            }
                            .listStyle(.plain)
                            .navigationTitle("Search")
                        }
                        
                    }
                }
                .searchable(text: $viewModel.searchQuery)
                
            } else {
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
            }
        }
        .disableAutocorrection(true)
        .onSubmit(of: .search) {
            Task {
                await viewModel.searchMoviesAndTVShows(searchQuery: viewModel.searchQuery)
                viewModel.pickerVisible = true
            }
        }
        .navigationViewStyle(.stack)
    }
}

//struct SearchScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchScreen()
//    }
//}
