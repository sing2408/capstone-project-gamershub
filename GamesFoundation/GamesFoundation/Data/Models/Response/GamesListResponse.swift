//
//  GamesListResponse.swift
//  GamesFoundation
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public struct GamesListResponse: Codable {
    public let count: Int
    public let results: [GameResponse]
}

