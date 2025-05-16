//
//  GamesRepositoryProtocol.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation
import Combine

public protocol GamesRepositoryProtocol {
    func getGames(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), any Error>
    func getGameDetail(id: Int) -> AnyPublisher<Game, any Error>
}
