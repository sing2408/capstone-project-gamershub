//
//  CoreDataSetup.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 13/05/25.
//

import SwiftUI
import CoreData

public class CoreDataSetup: @unchecked Sendable {
    public static let shared = CoreDataSetup()
    public let persistenceController = PersistenceController.shared

    public init() {}
    
}
