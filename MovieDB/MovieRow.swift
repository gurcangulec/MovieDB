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
            Text(movie.originalTitle)
        } label: {
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
                    .frame(width: 80, height: 120)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Image(systemName: "photo")
                        .frame(width: 80, height: 120)
                        .background(.ultraThinMaterial)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(alignment: .leading) {
                    Text(movie.originalTitle)
                        .font(.caption.weight(.heavy))
                    ExpandableText(text: movie.overview)
                        .expandButton(TextSet(text: "more", font: .body, color: .blue))
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
