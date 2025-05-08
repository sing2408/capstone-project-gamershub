//
//  Game.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation

struct Game: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let imageUrl: String?
    let description: String?
    let rating: Double?
    let released: String?
    let genres: [Genre]
    let tags: [Tag]
    var imageData: Data?
    
    static func == (lhs: Game, rhs: Game) -> Bool {
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

struct Genre: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
}

struct Tag: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
}
