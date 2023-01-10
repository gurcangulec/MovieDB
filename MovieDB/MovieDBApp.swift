//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 18.06.2022.
//

import SwiftUI

@main
struct MovieDBApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
