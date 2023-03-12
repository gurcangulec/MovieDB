//
//  Constants.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 31.01.2023.
//

import Foundation

struct Constants {
    static let APIKEY = ENV.API_KEY
    static let imageURL = "https://image.tmdb.org/t/p/original"
    static let baseURL = "https://api.themoviedb.org/3/"
    
    var email = ""
    
    let noSupportText = "You need to set a mail account in order to leave a feedback"
    let contentPreText = "I would like to give you my honest feedback."
    let sendButtonText = "Give Feedback"
    let subject = "Feedback"
    
    static let shared = Constants()
    
    init(){
        if let file = Bundle.main.path(forResource: "Email", ofType: "txt"){
            do {
                self.email = try String(contentsOfFile: file)
            } catch let error {
                print(error)
            }
        }
    }
}
