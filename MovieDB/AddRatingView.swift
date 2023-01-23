//
//  AddRatingView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 16.01.2023.
//

import SwiftUI

struct StarView: View {
    @Binding var rating: Int

    var label = ""

    var maximumRating = 10

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .font(.title3)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct AddRatingView: View {
    
    let movie: Movie
    let width: Double
    let height: Double
    @State private var removeFromWatchlist = true
    @State private var rating: Int = 0
    @State private var notes = ""
    @State private var showImage = true
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    if showImage {
                        VStack {
                            ImageView(urlString: "\(url)\(movie.unwrappedPosterPath)", width: width, height: height)
                                .padding(.bottom)
                                .padding(.bottom)
                            Text("Would you like to rate the movie?")
                                .multilineTextAlignment(.center)
                                .font(.body.bold())
                                .padding(.bottom)
                                .padding(.bottom)
                        }
                        .transition(.move(edge: .top))
                    }

                    
                    StarView(rating: $rating)
                        .padding(.bottom)
                    
                    Divider()
                        .padding(.bottom)
                    
                    Toggle("Remove from Watchlist?", isOn: $removeFromWatchlist)
                    
                    Spacer()
                    
                    Button {
                        let rateMovie = StoredMovie(context: moc)
                        rateMovie.id = Int32(movie.id)
                        rateMovie.userRating = Int16(rating)
                        rateMovie.title = movie.originalTitle
                        rateMovie.releaseDate = movie.formattedReleaseDateForStorage
                        rateMovie.dateAdded = Date.now
                        rateMovie.posterPath = movie.unwrappedPosterPath
                        rateMovie.rating = movie.voteAverage
                        rateMovie.backdropPath = movie.backdropPath
                        rateMovie.overview = movie.overview
                        rateMovie.rated = true
                        
                        try? moc.save()
                        
                        dismiss()
                    } label: {
                        Label("Rate", systemImage: "star.fill")
                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .center)
                    }
                    .buttonStyle(.bordered)
                    .padding(.bottom, 10)
                    
                }
                .frame(maxWidth: geo.size.width * 0.9)
                .navigationTitle("Rate the Movie")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

//struct AddRatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRatingView()
//    }
//}
