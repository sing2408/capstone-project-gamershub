//
//  GameDetailResponse.swift
//  GamesFoundation
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public struct GameDetailResponse: Codable {
    public let id: Int
    public let description_raw: String
    public let rating: Double?
    public let released: String?
    public let genres: [GenreDetail]
    public let tags: [TagDetail]
    public let background_image: String?
    public let name: String
}

public struct GenreDetail: Codable {
    public let id: Int
    public let name: String
}

public struct TagDetail: Codable {
    public let id: Int
    public let name: String
}
