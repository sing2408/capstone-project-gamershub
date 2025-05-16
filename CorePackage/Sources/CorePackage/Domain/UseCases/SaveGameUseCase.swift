//
//  SaveGameUseCase.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public protocol SaveGameUseCaseProtocol {
    func execute(game: SavedGame) -> Result<Void, Error>
}

public class SaveGameUseCase: SaveGameUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    public init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(game: SavedGame) -> Result<Void, Error> {
        return repository.saveGame(game: game)
    }
}
