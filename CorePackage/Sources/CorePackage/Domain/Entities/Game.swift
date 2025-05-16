//
//  Game.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public struct Game: Identifiable, Equatable, Hashable {
    public let id: Int
    public let title: String
    public let imageUrl: String?
    public let description: String?
    public let rating: Double?
    public let released: String?
    public let genres: [Genre]
    public let tags: [Tag]
    public var imageData: Data?
    public init(id: Int,
                title: String,
                imageUrl: String? = nil,
                description: String? = nil,
                rating: Double? = nil,
                released: String? = nil,
                genres: [Genre] = [],
                tags: [Tag] = [],
                imageData: Data? = nil) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.description = description
        self.rating = rating
        self.released = released
        self.genres = genres
        self.tags = tags
        self.imageData = imageData
    }
    public static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.description == rhs.description &&
        lhs.rating == rhs.rating &&
        lhs.released == rhs.released &&
        lhs.genres == rhs.genres &&
        lhs.tags == rhs.tags
    }
}

public struct Genre: Identifiable, Equatable, Hashable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public struct Tag: Identifiable, Equatable, Hashable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
