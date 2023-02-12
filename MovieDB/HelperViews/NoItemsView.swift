//
//  NoItemsView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 10.02.2023.
//

import SwiftUI

struct NoItemsView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
            VStack(spacing: 10) {
                Text(icon)
                    .font(.largeTitle)
                    
                Text(title)
                    .fontWeight(.semibold)
                Text(message)
            }
            .multilineTextAlignment(.center)
            .padding(40)
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsView(icon: "🤓", title: "There are no items to display.", message: "You didn't add any movies to your watchlist.")
    }
}
