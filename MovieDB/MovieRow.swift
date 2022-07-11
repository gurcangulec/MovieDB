//
//  MovieRow.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 29.06.2022.
//

import SwiftUI
import ExpandableText
import Kingfisher
import Accelerate

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
                        .foregroundColor(.white)
                }
                GeometryReader { geo in
                    VStack(alignment: .leading, spacing: 3) {
                        Text(movie.originalTitle)
                            .font(.headline.bold())
                        
                        Text(movie.formattedReleaseDate)
                            .padding(.bottom)
                        
                        Text(movie.overview)
                            .font(.body)

                    }
                    .frame(height: geo.size.height * 0.98)
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
