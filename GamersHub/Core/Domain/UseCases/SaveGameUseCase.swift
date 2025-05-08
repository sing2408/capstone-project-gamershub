//
//  SaveGameUseCase.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import Foundation

protocol SaveGameUseCaseProtocol {
    func execute(game: SavedGame) -> Result<Void, Error>
}

class SaveGameUseCase: SaveGameUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(game: SavedGame) -> Result<Void, Error> {
        return repository.saveGame(game: game)
    }
}
