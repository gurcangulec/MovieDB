//
//  FullCrewView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 10.08.2022.
//

import SwiftUI

struct FullCrewView: View {
    let movie: Movie?
    let tvShow: TVShow?
    let cast: [CastMember]
    let crew: [CrewMember]
    
    var body: some View {

        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Cast")
                    .font(.title.bold())
                Divider()
                ForEach(cast) { c in
                    VStack(alignment: .leading) {
                        Text(c.originalName)
                            .font(.title2)
                        Text(c.character ?? "")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                Text("Crew")
                    .font(.title.bold())
                Divider()
                ForEach(crew) { c in
                    VStack(alignment: .leading) {
                        Text(c.originalName)
                            .font(.title2)
                        if let job = c.job {
                            Text(job)
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding(25)
            .frame(maxWidth: .infinity)
        }
//        .task {
//            cast = await FetchData.downloadCast(movieId: movie.id)
//            crew = await FetchData.downloadCrew(movieId: movie.id)
//        }
        
    }
}

//struct FullCrewView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCrewView(movie: .example)
//    }
//}
