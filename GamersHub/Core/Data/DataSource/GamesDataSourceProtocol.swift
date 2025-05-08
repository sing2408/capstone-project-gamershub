//
//  GamesDataSourceProtocol.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 03/04/25.
//

import Foundation
import Combine

protocol GamesDataSourceProtocol {
    func getGames(page: Int, searchQuery: String?) -> AnyPublisher<(GamesListResponse, PaginationInfo), any Error>
    func getGameDetails(id: Int) -> AnyPublisher<GameDetailResponse, any Error>
}
