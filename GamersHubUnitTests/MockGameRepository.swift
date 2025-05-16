//
//  MockGameRepository.swift
//  GamersHubUnitTests
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import Foundation
@testable import GamersHub
import Combine
import CorePackage

class MockGamesRepository: GamesRepositoryProtocol {
    var gamesResult: Result<([Game], PaginationInfo), Error>!
    var gameDetailResult: Result<Game, Error>!
    var searchResult: Result<([Game], PaginationInfo), Error>!
    var searchCalled = false
    var searchQuery: String?

    func getGames(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), any Error> {
        self.searchQuery = searchQuery
        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            searchCalled = true
            if searchResult != nil {
                 return Result<([Game], PaginationInfo),
                                Error>.Publisher(searchResult!).eraseToAnyPublisher()
            } else {
                return Fail(error: NSError(domain: "MockError",
                                           code: 1,
                                           userInfo: [NSLocalizedDescriptionKey: "Search result was nil"]))
                    .eraseToAnyPublisher()
            }
        } else {
            searchCalled = false
             if gamesResult != nil {
                  return Result<([Game], PaginationInfo), Error>.Publisher(gamesResult!).eraseToAnyPublisher()
             } else {
                return Fail(error: NSError(domain: "MockError",
                                           code: 1,
                                           userInfo: [NSLocalizedDescriptionKey: "Games result was nil"]))
                    .eraseToAnyPublisher()
             }
        }
    }
    func getGameDetail(id: Int) -> AnyPublisher<Game, any Error> {
        return Result<Game, Error>.Publisher(gameDetailResult!).eraseToAnyPublisher()
    }
}
