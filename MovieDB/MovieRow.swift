//
//  MovieRow.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import ExpandableText
import Kingfisher

struct MovieRow: View {
    let movie: Movie
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        NavigationLink {
            MovieView(movie: movie)
        } label: {
            HStack {
                if let unwrappedPath = movie.posterPath {
                    let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                    KFImage(unwrappedPath)
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .posterStyle()
                        
                } else {
                    Image(systemName: "photo")
                        .posterStyle()
                }
                
                VStack(alignment: .leading) {
                    Text(movie.originalTitle)
                        .font(.headline.bold())
//                        .shadow(radius: 10)
                    
                    Text(movie.formattedReleaseDate)
                    
//                    Text(movie.formattedDate )
//                        .font(.footnote.weight(.light))
                    ExpandableText(text: movie.overview)
                        .expandButton(TextSet(text: "more", font: .body, color: .blue))
                        .font(.body)

                }
            }
        }
    }
}


struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: .example)
    }
}
