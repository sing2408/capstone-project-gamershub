//
//  SavedGamesRepositoryProtocol.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import Foundation

protocol SavedGamesRepositoryProtocol {
    func saveGame(game: SavedGame) -> Result<Void, Error>
    func unsaveGame(gameId: Int) -> Result<Void, Error>
    func isGameSaved(gameId: Int) -> Bool
    func fetchSavedGames() -> [SavedGame]
}
