//
//  GetGamesListUseCase.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import Foundation
import Combine

protocol GetGamesListUseCaseProtocol {
    func execute(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), Error>
}

class GetGamesListUseCase: GetGamesListUseCaseProtocol {
    
    private let repository: GamesRepositoryProtocol
    
    init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int, searchQuery: String?) -> AnyPublisher<([Game], PaginationInfo), any Error> {
            return repository.getGames(page: page, searchQuery: searchQuery) 
        }
}
