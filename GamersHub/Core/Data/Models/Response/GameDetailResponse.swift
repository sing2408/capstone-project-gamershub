//
//  GameDetailResponse.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation

struct GameDetailResponse: Codable {
    let id: Int
    let description_raw: String
    let rating: Double?
    let released: String?
    let genres: [GenreDetail]
    let tags: [TagDetail]
    let background_image: String?
    let name: String
}

struct GenreDetail: Codable {
    let id: Int
    let name: String
}

struct TagDetail: Codable {
    let id: Int
    let name: String
}
