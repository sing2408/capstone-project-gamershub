//
//  ContentView.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//
//

import SwiftUI
import CorePackage
import About
import Saved
import Home

struct ContentView: View {
    let router = Router()
    var body: some View {

        TabView {
            router.makeHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            router.makeSavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            router.makeAboutView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
