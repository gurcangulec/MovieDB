//
//  HomeSectionsView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import SwiftUI

struct HomeSectionsView: View {
    @ObservedObject var viewModel: TheViewModel
    
    let title: String
    let url: String = "https://image.tmdb.org/t/p/original/"
    let width: Double
    let height: Double
    let movies: [Movie]?
    let tvShows: [TVShow]?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(title)")
                    .font(.title2.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, height)
                    .padding(.leading, 15)
                
                NavigationLink {
                    AllPopular(viewModel: viewModel, movies: movies, tvShows: tvShows, navTitle: title)
                } label: {
                    Text("See All")
                    
                    Image(systemName: "chevron.right")
                }
                .padding(.trailing, 15)
            }
            SideScroller(viewModel: viewModel, tvShows: tvShows, movies: movies, cast: nil, crew: nil, url: url, geoWidth: width)
        }
    }
}

//struct HomeSectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeSectionsView()
//    }
//}
