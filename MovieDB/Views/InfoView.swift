//
//  InfoView.swift
//  MovieDB
//
//  Created by Gürcan Güleç on 15.02.2023.
//

import SwiftUI

enum SchemeType: Int, CaseIterable {
    case system
    case light
    case dark
}

extension SchemeType {
    var title: String {
        switch self {
        case .system:
            return "Automatic"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}

struct InfoView: View {

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
            Form {
                
                Section {
                    Picker(selection: $systemTheme, content: {
                        ForEach(SchemeType.allCases, id:\.self) { item in
                            Text(item.title)
                                .tag(item.rawValue)
                        }
                    }, label: {
                        Text("Pick a theme")
                    })
                    .pickerStyle(.segmented)
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("Select between light or dark theme or set it to automatic for letting the system decide for you.")
                }
                
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("0.1.0(7)")
                    }
                    HStack(alignment: .center, spacing: 20) {
                        Image("themoviedb")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 50)
                        
                        Text("All film-related metadata used in Letterboxd, including actor, director and studio names, synopses, release dates, trailers and poster art is supplied by The Movie Database (TMDb).")
                            .font(.caption)
                            .foregroundColor(.secondary)

                    }
                    .frame(maxHeight: 100)
                } header: {
                    Text("About")
                }
            }
            .navigationTitle("Info")
            .preferredColorScheme(selectedScheme)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoView()
        }
    }
}
