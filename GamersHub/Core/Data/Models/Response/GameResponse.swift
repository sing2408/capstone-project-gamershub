//
//  GameResponse.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation

struct GameResponse: Codable {
    let id: Int
    let slug: String
    let name: String
    let background_image: String?
    let released: String?
}
