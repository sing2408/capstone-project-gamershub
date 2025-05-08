//
//  GamesListResponse.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation

struct GamesListResponse: Codable {
    let count: Int
    let results: [GameResponse]
}
