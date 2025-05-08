//
//  CoreDataSetup.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/05/25.
//

import SwiftUI
import CoreData

class CoreDataSetup {
    static let shared = CoreDataSetup()
    let persistenceController = PersistenceController.shared

    private init() {}
    
}
