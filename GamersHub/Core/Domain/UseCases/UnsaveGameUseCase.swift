//
//  UnsaveGameUseCase.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import Foundation

protocol UnsaveGameUseCaseProtocol {
    func execute(gameId: Int) -> Result<Void, Error>
}

class UnsaveGameUseCase: UnsaveGameUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(gameId: Int) -> Result<Void, Error> {
        return repository.unsaveGame(gameId: gameId)
    }
}
