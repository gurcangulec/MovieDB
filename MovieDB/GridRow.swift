//
//  GridRow.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 02.07.2022.
//

import SwiftUI

struct GridView: View {
    let movie: Movie
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        VStack {
            HStack {
                if let unwrappedPath = movie.posterPath {
                    let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                    
                    AsyncImage(url: unwrappedPath) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        default:
                            Image(systemName: "photo")
                        }
                    }
                    .frame(width: 100, height: 150)
                    .clipped()
                    
                } else {
                    Image(systemName: "photo")
                        .frame(width: 100, height: 150)
                        .background(.ultraThinMaterial)
                        .clipped()
                }
                
                
                VStack(alignment: .leading) {
                    Text("\(movie.originalTitle)")
                        .font(.caption.weight(.heavy))
                    //                                    ExpandableText(text: "\(movie.overview)")
                    //                                        .lineLimit(4)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        Color.gray
                            .opacity(0.5)
                    )
            )
            .background(.ultraThinMaterial)
            .padding(.bottom)
        }
        .padding([.leading, .trailing])
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(movie: .example)
    }
}
