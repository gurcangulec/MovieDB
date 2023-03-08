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
    
    @ObservedObject var viewModel: TheViewModel
    
    @Binding var rated: Bool
    
    let movie: Movie?
    let tvShow: TVShow?
    let width: Double
    let height: Double
    @State private var removeFromWatchlist = true
    @State private var rating: Int = 0
    @State private var notes = ""
    @State private var showImage = true
    @Environment(\.dismiss) var dismiss
//    @Environment(\.managedObjectContext) var moc
    
    private let url = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    if showImage {
                        VStack {
                            if let movie {
                                ImageView(urlString: "\(url)\(movie.unwrappedPosterPath)", width: width, height: height)
                                    .padding(.bottom)
                                    .padding(.bottom)
                            }
                            if let tvShow {
                                ImageView(urlString: "\(url)\(tvShow.unwrappedPosterPath)", width: width, height: height)
                                    .padding(.bottom)
                                    .padding(.bottom)
                            }
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
                    
                    if rating != 0 {
                        Text("Your Rating: \(rating)")
                            .font(.title3.bold())
                            .padding(.vertical, 3)
                    }
                    
                    Spacer()
                    
                    Button {
                        if let movie {
                            viewModel.addToRated(movie: movie, tvshow: tvShow, rating: rating)
                            withAnimation {
                                rated = true
                            }
                        }
                        
                        if let tvShow {
                            viewModel.addToRated(movie: nil, tvshow: tvShow, rating: rating)
                        }
                        dismiss()
                    } label: {
                        Label("Rate", systemImage: "star.fill")
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 44, alignment: .center)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    .disabled(rating == 0)
                    .buttonStyle(.borderless)
                    .padding(.bottom, 10)
                    
                }
                .frame(maxWidth: geo.size.width * 0.9)
                .navigationTitle("Rate the Movie")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .cancel) {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

//struct AddRatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRatingView()
//    }
//}
