//
//  FetchSavedGamesUseCaseProtocol.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public protocol FetchSavedGamesUseCaseProtocol {
    func execute() -> [SavedGame]
}

public class FetchSavedGamesUseCase: FetchSavedGamesUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    public init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() -> [SavedGame] {
        return repository.fetchSavedGames()
    }
}
