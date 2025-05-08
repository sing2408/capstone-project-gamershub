//
//  ContentView.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//
//
//  ContentView.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView() 
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SavedView() 
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            AboutView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
