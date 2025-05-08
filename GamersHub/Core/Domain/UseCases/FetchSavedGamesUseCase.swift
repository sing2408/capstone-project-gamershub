//
//  FetchSavedGamesUseCase.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import Foundation

protocol FetchSavedGamesUseCaseProtocol {
    func execute() -> [SavedGame]
}

class FetchSavedGamesUseCase: FetchSavedGamesUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> [SavedGame] {
        return repository.fetchSavedGames()
    }
}
