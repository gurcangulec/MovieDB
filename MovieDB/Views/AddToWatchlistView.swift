//
//  AddToWatchlistView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import SwiftUI

struct AddToWatchlistView: View {
    @ObservedObject var viewModel: TheViewModel
    
    let movie: Movie?
    let tvShow: TVShow?
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
                            if let tvShow {
                                ImageView(urlString: "\(url)\(tvShow.unwrappedPosterPath)", width: width, height: height)
                                    .padding(.bottom, 10)
                                Text("Would you like to add a note?")
                                    .multilineTextAlignment(.center)
                                    .font(.body.bold())
                            }
                            if let movie {
                                ImageView(urlString: "\(url)\(movie.unwrappedPosterPath)", width: width, height: height)
                                    .padding(.bottom, 10)
                                Text("Would you like to add a note?")
                                    .multilineTextAlignment(.center)
                                    .font(.body.bold())
                            }
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
                        if let movie {
                            viewModel.addToWatchlist(movie: movie, tvshow: nil, notes: notes)
                        }
                        
                        if let tvShow {
                            viewModel.addToWatchlist(movie: nil, tvshow: tvShow, notes: notes)
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
                    ToolbarItem(placement: .cancellationAction) {

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
