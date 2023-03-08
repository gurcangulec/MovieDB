//
//  InfoView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 15.02.2023.
//

import SwiftUI
import MessageUI

struct InfoView: View {
    
    @State private var sendEmail = false
    @State private var sendEmail2 = false
    let constants = Constants.shared
    let email = "gurcanglc@gmail.com"
    let email2 = "bilgehan_duman@hotmail.com"

    var body: some View {
            Form {
                
                Section {
                    if MFMailComposeViewController.canSendMail() {
                        
                        HStack {
                            Text("Developer")
                            Spacer()
                            Button {
                                sendEmail.toggle()
                            } label: {
                                Text("Gürcan Güleç")
                            }
                        }
                    
                        
                        HStack {
                            Text("Icon Design")
                            Spacer()
                            Button {
                                sendEmail2.toggle()
                            } label: {
                                Text("Bilgehan Duman")
                            }
                        }
                        
                    } else {
                        Text(constants.noSupportText)
                            .multilineTextAlignment(.center)
                    }
                    
                } header: {
                    Text("Contact Us")
                }
                
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("0.1.0(8)")
                    }
                    HStack(alignment: .center, spacing: 20) {
                        Image("themoviedb")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 50)
                        
                        Text("All film-related metadata used in Letterboxd, including actor, director and studio names, synopses, release dates, trailers and poster art is supplied by The Movie Database (TMDb).")
                            .font(.caption)
                            .foregroundColor(.secondary)

                    }
                    .frame(maxHeight: 100)
                } header: {
                    Text("About")
                }
                
            }
            .sheet(isPresented: $sendEmail) {
                MailView(content: constants.contentPreText, to: email, subject: constants.subject)
            }
            .sheet(isPresented: $sendEmail2) {
                MailView(content: constants.contentPreText, to: email2, subject: constants.subject)
            }
            .navigationTitle("Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoView()
        }
    }
}
