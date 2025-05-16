//
//  GamersHubApp.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import SwiftUI
import CorePackage

@main
struct GamersHubApp: App {
    let coreDataSetup = CoreDataSetup.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataSetup.persistenceController.container.viewContext)
        }
    }
}
