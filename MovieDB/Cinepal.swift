//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 18.06.2022.
//

import SwiftUI

@main
struct MovieDBApp: App {
    
    @StateObject private var theViewModel = TheViewModel(context: DataController.shared.persistentStoreContainer.viewContext)
    
    var body: some Scene {
        WindowGroup {
            
            let viewContext = DataController.shared.persistentStoreContainer.viewContext
            
            MainScreen(viewModel: TheViewModel(context: viewContext))
                .environment(\.managedObjectContext, viewContext)
                .environmentObject(theViewModel)
        }
    }
}
