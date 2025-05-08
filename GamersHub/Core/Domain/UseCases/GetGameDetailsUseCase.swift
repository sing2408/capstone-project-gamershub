//
//  GetGameDetailsUseCase.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import Foundation
import Combine

protocol GetGameDetailsUseCaseProtocol {
    func execute(id: Int) -> AnyPublisher<Game, Error>
}

class GetGameDetailsUseCase: GetGameDetailsUseCaseProtocol {
    private let repository: GamesRepositoryProtocol
    
    init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) -> AnyPublisher<Game, Error> {
        return repository.getGameDetail(id: id)
    }
}
