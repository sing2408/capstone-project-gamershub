//
//  UnsaveGameUseCase.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public protocol UnsaveGameUseCaseProtocol {
    func execute(gameId: Int) -> Result<Void, Error>
}

public class UnsaveGameUseCase: UnsaveGameUseCaseProtocol {
    private let repository: SavedGamesRepositoryProtocol

    public init(repository: SavedGamesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(gameId: Int) -> Result<Void, Error> {
        return repository.unsaveGame(gameId: gameId)
    }
}
