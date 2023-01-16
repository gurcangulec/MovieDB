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
    @State private var notes = ""
    @State private var showImage = true
    @FocusState private var textEditorFocused: Bool
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
                                .padding(.bottom, 10)
                            Text("Would you like to add a note?")
                                .multilineTextAlignment(.center)
                                .font(.body.bold())
//                                .padding()
                        }
                        .transition(.move(edge: .top))
                    }

                    ZStack(alignment: .topLeading) {
                        if notes.isEmpty {
                            Text("Add a note...")
                                .padding()
                        }
                        
                        TextEditor(text: $notes)
                            .focused($textEditorFocused)
                            .autocorrectionDisabled()
                            .padding(8)
                            .padding(.leading, 2)
//                            .overlay(RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.secondary).opacity(0.5))
//                            .background(Color.yellow.opacity(0.5))
                            .cornerRadius(15)
                            .opacity(notes.isEmpty ? 0.25 : 1)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.secondary).opacity(0.8))
                            .onChange(of: textEditorFocused) { _ in
                                withAnimation {
                                    showImage = false
                                }
                            }
                            

                    }
                    
                    
                    Spacer()
                    
                    Button {
                        let watchlistMovie = WatchlistMovie(context: moc)
                        watchlistMovie.id = Int32(movie.id)
                        watchlistMovie.title = movie.originalTitle
                        watchlistMovie.posterPath = movie.posterPath
                        watchlistMovie.releaseDate = movie.formattedReleaseDate
                        watchlistMovie.overview = movie.overview
                        watchlistMovie.dateAdded = Date.now
                        watchlistMovie.rating = movie.voteAverage
                        watchlistMovie.backdropPath = movie.backdropPath
                        
                        do {
                            try moc.save()
                        } catch {
                            print("Something went wrong while saving: \(error.localizedDescription)")
                        }
                        
                        dismiss()
                    } label: {
                        Label("Add to Watchlist", systemImage: "plus")
                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .center)
                    }
                    .buttonStyle(.bordered)
                    .padding(.bottom, 10)
                    
                }
                .frame(maxWidth: geo.size.width * 0.9)
                .navigationTitle("Add to Watchlist")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {

                        Button("Cancel") {
                            textEditorFocused = false
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
//struct AddToWatchlistView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddToWatchlistView()
//    }
//}