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
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select category", selection: $viewModel.chosenCategory) {
                    ForEach(viewModel.categories, id:\.self) {
                        Text($0)
                    }
                }
                .padding([.leading, .trailing])
                .pickerStyle(.segmented)
                
                if viewModel.chosenCategory == "Movie" {
                    if viewModel.searchedMovies.isEmpty {
                        if viewModel.searchQuery.isEmpty {
                            HStack {
                                Text("Popular Movies")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding([.leading, .trailing])
                            .padding(.bottom, -3)
                            
                            List(viewModel.popularMovies) { movie in
                                MovieAndTVShowRow(viewModel: viewModel, movie: movie, tvShow: nil)
                            }
                            .listStyle(.plain)
                        } else {
                            if isLoading {
                                Spacer()
                                NoItemsView(icon: "🧐",
                                            title: "There are no movies to display.",
                                            message: "Unfortunately, we couldn't find any movies matching your search query.")
                                Spacer()
                            } else {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    } else {
                        List(viewModel.searchedMovies) { movie in
                            MovieAndTVShowRow(viewModel: viewModel, movie: movie, tvShow: nil)
                        }
                        .listStyle(.plain)
                    }
                } else {
                    if viewModel.searchedTvShows.isEmpty {
                        if viewModel.searchQuery.isEmpty {
                            HStack {
                                Text("Popular TV Shows")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding([.leading, .trailing])
                            List(viewModel.popularTVShows) { tvShow in
                                MovieAndTVShowRow(viewModel: viewModel, movie: nil, tvShow: tvShow)
                            }
                            .listStyle(.plain)
                        } else {
                            if isLoading {
                                Spacer()
                                NoItemsView(icon: "🧐",
                                            title: "There are no TV Shows to display.",
                                            message: "Unfortunately, we couldn't find any TV shows matching your search query.")
                                Spacer()
                            } else {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    } else {
                        List(viewModel.searchedTvShows) { tvShow in
                            MovieAndTVShowRow(viewModel: viewModel, movie: nil, tvShow: tvShow)
                        }
                        .listStyle(.plain)
                        
                    }
                    
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchQuery)
            .disableAutocorrection(true)
            .onChange(of: viewModel.searchQuery, perform: { _ in
                Task {
                    await viewModel.searchMoviesAndTVShows(searchQuery: viewModel.searchQuery)
                }
                delayView()
                self.isLoading = false
            })
        }
        .navigationViewStyle(.stack)
    }
    
    func delayView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = true
        }
    }
}

//struct SearchScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchScreen()
//    }
//}
