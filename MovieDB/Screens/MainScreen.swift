//
//  MainScreen.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var viewModel: TheViewModel
    
    var body: some View {
        TabView {
            HomeScreen(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house.circle")
                }
                .tag(0)
            SearchScreen(viewModel: viewModel)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
                .tag(1)
            WatchlistScreen(viewModel: viewModel)
                .tabItem {
                    Label("Watchlist", systemImage: "play.circle")
                }
                .tag(2)
            RatingsList(viewModel: viewModel)
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
