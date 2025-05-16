//
//  SavedGame.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public struct SavedGame: Identifiable, Codable {
    public let id: Int
    public let title: String
    public let imageUrl: String?
    public let released: String?
    public var saveDate: Date = Date()
    public var imageData: Data?

    public init(id: Int, title: String, imageUrl: String?, released: String?, saveDate: Date, imageData: Data?) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.released = released
        self.saveDate = saveDate
        self.imageData = imageData
    }

    public init(id: Int, title: String, imageUrl: String?, released: String?, imageData: Data?) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.released = released
        self.saveDate = Date()
        self.imageData = imageData
    }
}
