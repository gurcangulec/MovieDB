//
//  MainView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import SwiftUI

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
