//
//  GetGamesListUseCase.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation
import Combine

public protocol GetGamesListUseCaseProtocol {
    func execute(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), Error>
}

public class GetGamesListUseCase: GetGamesListUseCaseProtocol {

    private let repository: GamesRepositoryProtocol

    public init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), any Error> {
            return repository.getGames(page: page, searchQuery: searchQuery)
        }
}
