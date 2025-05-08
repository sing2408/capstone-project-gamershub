//
//  GamesRepositoryProtocol.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation
import Combine

protocol GamesRepositoryProtocol {
    func getGames(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), any Error>
    func getGameDetail(id: Int) -> AnyPublisher<Game, any Error>
}
