//
//  ImageView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 12.01.2023.
//

import Kingfisher
import SwiftUI

struct ImageView: View {
    let urlString: String?
    let width: Double
    let height: Double
    
    private var unwrappedURLString: String {
        urlString ?? "Unknown"
    }
    
    var body: some View {
        if urlString != nil {
            KFImage(URL(string: unwrappedURLString))
                .placeholder {
                    ProgressView()
                        .frame(width: width)
                }
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            Color.gray
                                .opacity(0.5)
                        )
                )
                .padding([.top, .bottom], 5)
                .padding(.leading, 5)
        } else {
            Image(systemName: "photo")
                .font(.system(size: 20))
                .frame(width: width, height: height)
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
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: "some string", width: 300, height: 300)
    }
}
