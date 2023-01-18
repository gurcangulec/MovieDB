//
//  TVShowView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import Kingfisher
import SwiftUI

struct TVShowView: View {
    let tvShow: TVShow
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    if let unwrappedPath = tvShow.backdropPath {
                        let unwrappedPath = URL(string: "\(url)\(unwrappedPath)")
                        KFImage(unwrappedPath)
                            .placeholder {
                                ProgressView()
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                        
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .frame(width: geo.size.width, height: geo.size.width * 0.55)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Divider()
                        
                        Group {
                            Text(tvShow.originalTitle)
                                .font(.title.weight(.semibold))
                                .padding(.bottom, geo.size.height * 0.01)
                            
                            HStack {
                                Image(systemName: "star.fill")
                                Text("\(tvShow.convertToString)/10")
                                    .font(.body)
                                
                                Spacer()
                                
                                Image(systemName: "calendar")
                                Text("\(tvShow.formattedReleaseDateForViews)")
                                    .font(.body)
                                
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            .padding(.bottom, geo.size.height * 0.01)
                            
                            Text(tvShow.overview)
                                .font(.body)
                                .padding(.bottom, geo.size.height * 0.01)
                            
                            HStack {
                                Button {
//                                    showingSheetWatchlist.toggle()
                                    
//                                    do {
//                                        try moc.save()
//                                    } catch {
//                                        print("Something went wrong while saving: \(error.localizedDescription)")
//                                    }
                                    
//                                    hapticEngine.complexSuccess()
                                    
                                } label: {
                                    Label("Watchlist", systemImage: "plus")
                                        .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                }
                                .buttonStyle(.bordered)
                                
                                Button {
//                                    showingSheetRating.toggle()
//                                    hapticEngine.complexSuccess()
                                    
                                } label: {
                                    Label("Rate", systemImage: "star.fill")
                                        .frame(maxWidth: .infinity, minHeight: 32, alignment: .leading)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(tvShow.originalTitle)
        }
    }
}

//struct TVShowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowView()
//    }
//}
