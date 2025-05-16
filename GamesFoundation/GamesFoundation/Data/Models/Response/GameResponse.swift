//
//  GameResponse.swift
//  GamesFoundation
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public struct GameResponse: Codable {
    public let id: Int
    public let slug: String
    public let name: String
    public let background_image: String?
    public let released: String?
}

