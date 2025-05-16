//
//  SavedGameRepositoryProtocol.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public protocol SavedGamesRepositoryProtocol {
    func saveGame(game: SavedGame) -> Result<Void, Error>
    func unsaveGame(gameId: Int) -> Result<Void, Error>
    func isGameSaved(gameId: Int) -> Bool
    func fetchSavedGames() -> [SavedGame]
}
