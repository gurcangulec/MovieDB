//
//  PosterImageStyle.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 02.07.2022.
//

import Foundation
import SwiftUI

struct PosterImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 90, height: 135)
            .background(Color(.systemGray5))
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        Color.gray
                            .opacity(0.1)
                    )
            )
            .padding([.top, .bottom, .trailing], 5)
    }
}

extension View {
    func posterStyle() -> some View {
        modifier(PosterImage())
    }
}
