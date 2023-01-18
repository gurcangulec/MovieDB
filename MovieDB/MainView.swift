//
//  MainView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import CoreData
import SwiftUI

extension StoredMovie {
    static var defaultFetchRequest: NSFetchRequest<StoredMovie> {
        let request: NSFetchRequest<StoredMovie> = StoredMovie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "watchlisted == true")
        return request
    }
    static var ratedFetchRequest: NSFetchRequest<StoredMovie> {
        let request: NSFetchRequest<StoredMovie> = StoredMovie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "rated == true")
        return request
    }
}

struct MainView: View {
    
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house.circle")
                }
                .tag(0)
            Search()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
                .tag(1)
            WatchList()
                .tabItem {
                    Label("Watchlist", systemImage: "play.circle")
                }
                .tag(2)
            Ratings()
                .tabItem {
                    Label("Ratings", systemImage: "star.circle")
                }
                .tag(3)
        }
        // Fixes the inconsistency regarding the TabView background
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
