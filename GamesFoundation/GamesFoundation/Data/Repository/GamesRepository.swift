//
//  GamesRepository.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation
import Combine
import CorePackage

public class GamesRepository: GamesRepositoryProtocol {
    private let dataSource: GamesDataSourceProtocol
    
    public init(dataSource: GamesDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    public func getGames(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), any Error> {
            return dataSource.getGames(page: page, searchQuery: searchQuery)
                .map { (response, paginationInfo) in
                    let games = GamesMapper.mapGames(from: (response, paginationInfo))
                    return (games, paginationInfo)
                }
                .eraseToAnyPublisher()
        }
    
    public func getGameDetail(id: Int) -> AnyPublisher<Game, any Error> {
        return dataSource.getGameDetails(id: id)
            .map { detailResponse in
                let mappedGame = GamesMapper.mapGameDetail(from: detailResponse)
                return mappedGame
            }
            .eraseToAnyPublisher()
    }
}
