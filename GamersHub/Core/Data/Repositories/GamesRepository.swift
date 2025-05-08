//
//  GamesRepository.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation
import Combine

class GamesRepository: GamesRepositoryProtocol {
    private let dataSource: GamesDataSourceProtocol
    
    init(dataSource: GamesDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getGames(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), any Error> {
            return dataSource.getGames(page: page, searchQuery: searchQuery)
                .map { (response, paginationInfo) in
                    let games = GamesMapper.mapGames(from: (response, paginationInfo))
                    return (games, paginationInfo)
                }
                .eraseToAnyPublisher()
        }
    
    func getGameDetail(id: Int) -> AnyPublisher<Game, any Error> {
        return dataSource.getGameDetails(id: id)
            .map { detailResponse in
                let mappedGame = GamesMapper.mapGameDetail(from: detailResponse)
                return mappedGame
            }
            .eraseToAnyPublisher()
    }
}
