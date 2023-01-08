//
//  SideScrollerCast.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 08.01.2023.
//

import SwiftUI
import Kingfisher

struct SideScrollerCast: View {
    let movie: Movie
    let cast: [CastMember]
    let crew: [CrewMember]
    let url: String
    let geoWidth: Double

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(cast) {castMember in
                    NavigationLink {
                        ActorView(movie: movie, cast: castMember)
                    } label: {
                        VStack {
                            if let unwrappedPath = castMember.profilePath {
                                let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                                KFImage(unwrappedPath)
                                    .placeholder {
                                        ProgressView()
                                            .frame(width: geoWidth * 0.3)
                                    }
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geoWidth * 0.3, height: geoWidth * 0.45)
                                    .clipped()
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                Color.gray
                                                    .opacity(0.5)
                                            )
                                    )
                                    .padding([.top, .bottom, .trailing], 5)

                            } else {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                    .frame(width: geoWidth * 0.3, height: geoWidth * 0.45)
                                    .aspectRatio(3.8, contentMode: .fit)
                                    .foregroundColor(.white)
                                    .background(.gray)
                                    .clipped()
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                Color.gray
                                                    .opacity(0.5)
                                            )
                                    )
                                    .padding([.top, .bottom, .trailing], 5)
                            }

                            VStack(spacing: 10) {
                                Text(castMember.originalName)
                                    .font(.headline)
                                    .frame(maxWidth: geoWidth * 0.3, alignment: .leading)

                                Text(castMember.character)
                                    .font(.caption)
                                    .frame(maxWidth: geoWidth * 0.3, alignment: .leading)
                            }
                            .frame(alignment: .leading)
                        }
                        .padding(.bottom)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

//struct SideScrollerCast_Previews: PreviewProvider {
//    static var previews: some View {
//        SideScrollerCast()
//    }
//}
