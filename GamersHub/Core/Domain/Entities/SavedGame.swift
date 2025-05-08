//
//  SavedGame.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import UIKit // Import for UIImage
import Foundation

struct SavedGame: Identifiable, Codable {
    let id: Int
    let title: String
    let imageUrl: String?  
    let released: String?
    var saveDate: Date = Date()
    var imageData: Data?
}
