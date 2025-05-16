//
//  GamesDataSourceProtocol.swift
//  GamesFoundation
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation
import Combine
import CorePackage

public protocol GamesDataSourceProtocol {
    func getGames(page: Int, searchQuery: String?) -> AnyPublisher<(GamesListResponse, PaginationInfo), any Error>
    func getGameDetails(id: Int) -> AnyPublisher<GameDetailResponse, any Error>
}

