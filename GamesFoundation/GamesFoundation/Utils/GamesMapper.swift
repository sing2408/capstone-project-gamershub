//
//  GamesMapper.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation
import CorePackage

struct GamesMapper {
    static func mapGames(from response: (GamesListResponse, PaginationInfo)) -> [Game] {
            return response.0.results.map { gameResponse in
                Game(
                    id: gameResponse.id,
                    title: gameResponse.name,
                    imageUrl: gameResponse.background_image,
                    description: nil,
                    rating: nil,
                    released: gameResponse.released,
                    genres: [],
                    tags: []
                )
            }
        }

    static func mapGameDetail(from response: GameDetailResponse) -> Game {
        return Game(
            id: response.id,
            title: response.name,
            imageUrl: response.background_image,
            description: response.description_raw,
            rating: response.rating,
            released: response.released,
            genres: response.genres.map { Genre(id: $0.id, name: $0.name) },
            tags: response.tags.map { Tag(id: $0.id, name: $0.name) }
        )
    }
}
