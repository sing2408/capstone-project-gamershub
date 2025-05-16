//
//  IsGameSavedUseCase.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public protocol IsGameSavedUseCaseProtocol {
    func execute(gameId: Int) -> Bool
}

public class IsGameSavedUseCase: IsGameSavedUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    public init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(gameId: Int) -> Bool {
        return repository.isGameSaved(gameId: gameId)
    }
}
