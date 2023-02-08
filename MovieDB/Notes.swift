//
//  Notes.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 24.01.2023.
//

import SwiftUI

struct Notes: View {
    @FocusState private var textEditorFocused: Bool
    
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
                            ImageView(urlString: "\(Constants.imageURL)\(storedMovie.wMmoviePosterPath)", width: geo.size.width * 0.54, height: geo.size.width * 0.81)
                                .padding(.bottom, 10)
                            Text("Your Notes")
                                .font(.title3.bold())
                                .padding(5)
                        }
                        .padding()
                    }
                    
                        ZStack(alignment: .topLeading) {
                            if let notes = storedMovie.notes {
                                if notes.isEmpty {
                                    Text("Add a note...")
                                        .padding()
                                }
                                
                                TextEditor(text: Binding($storedMovie.notes)!)
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
                        }
                        Spacer()
                }
                .frame(maxWidth: geo.size.width * 0.9)
                .navigationTitle("Notes")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(role: .destructive) {
                            showingAlert.toggle()
                        } label: {
                            HStack {
                                Text("Delete")
                                    .font(.body.weight(.semibold))
                            }
                        }
                        .foregroundColor(storedMovie.notes == "" ? Color.secondary : Color.red)
                        .disabled(storedMovie.notes == "")
                    }
                }
                .confirmationDialog("Delete this note?", isPresented: $showingAlert, titleVisibility: .visible) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                                            storedMovie.notes = ""
                                            dismiss()
                                            viewModel.saveData()
                                        }
                }
            }
        }
    }
}

//struct Notes_Previews: PreviewProvider {
//    static var previews: some View {
//        Notes()
//    }
//}
