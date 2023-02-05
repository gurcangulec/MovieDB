//
//  Notes.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 24.01.2023.
//

import SwiftUI

struct Notes: View {
    
    @ObservedObject var viewModel: TheViewModel
    @ObservedObject var storedMovie: WatchlistedMovieEntity
    @State private var showImage = true
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    if showImage {
                        VStack {
                            ImageView(urlString: "\(viewModel.imageUrl)\(storedMovie.wMmoviePosterPath)", width: geo.size.width * 0.54, height: geo.size.width * 0.81)
                                .padding(.bottom, 10)
                            Text("Your Notes")
                                .font(.title3.bold())
                                .padding(5)
                            ScrollView {
                                Text(storedMovie.notes ?? "")
                            }
                        }
                        .padding()
                        Spacer()
                    }
                }
                .navigationTitle("Notes About \(storedMovie.wMovieTitle)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(role: .destructive) {
                            showingAlert.toggle()
                        } label: {
                            Label("Delete Title", systemImage: "trash")
                        }
                    }
                }
                .alert("Are you sure?", isPresented: $showingAlert, actions: {
                    Button("Cancel", role: .cancel) { }
                    Button("Yes", role: .destructive) {
                        storedMovie.notes = ""
                        dismiss()
                        viewModel.saveData()
                    }
                }, message: {
                    Text("Notes about \(storedMovie.wMovieTitle) will be deleted.")
                })
            }
        }
    }
}

//struct Notes_Previews: PreviewProvider {
//    static var previews: some View {
//        Notes()
//    }
//}
