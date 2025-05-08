//
//  IsGameSavedUseCase.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import Foundation

protocol IsGameSavedUseCaseProtocol {
    func execute(gameId: Int) -> Bool
}

class IsGameSavedUseCase: IsGameSavedUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(gameId: Int) -> Bool {
        return repository.isGameSaved(gameId: gameId)
    }
}
