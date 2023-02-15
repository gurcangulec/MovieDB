//
//  MainScreen.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 07.01.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var viewModel: TheViewModel
    
    // MARK: Theme settings. Not ideal but will do the job for now.
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue
    
    private var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
    
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
        .preferredColorScheme(selectedScheme)
    }
}
