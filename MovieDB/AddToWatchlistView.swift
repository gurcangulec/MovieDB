//
//  AddToWatchlistView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import SwiftUI

struct AddToWatchlistView: View {
    let movie: Movie
    let width: Double
    let height: Double
    @State private var notes: String = ""
    
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    ImageView(urlString: "\(url)\(movie.unwrappedPosterPath)", width: width, height: height)
                    Text("Add to Watchlist")
                    ZStack {
                        Text("som")
                        TextEditor(text: $notes)
                            .autocorrectionDisabled()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.secondary).padding(-5))
                        .padding(10)
                        
                    }
                    
                    Button("Add") {}
                    
                    Spacer()
                }
                .frame(maxWidth: geo.size.width * 0.8)
                .navigationTitle("Add to Watchlist")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

//struct AddToWatchlistView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddToWatchlistView()
//    }
//}
