//
//  TVShowView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 13.01.2023.
//

import SwiftUI

struct TVShowView: View {
    let tvShow: TVShow
    
    var body: some View {
        Text(tvShow.originalTitle)
    }
}

//struct TVShowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowView()
//    }
//}
