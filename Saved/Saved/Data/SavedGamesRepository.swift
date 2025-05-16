//
//  SavedGamesRepository.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import CoreData
import UIKit
import CorePackage

public class SavedGamesRepository: SavedGamesRepositoryProtocol {
    private let container: NSPersistentContainer
    private let savedGameEntityName = "SavedGameCoreData"
    private let context: NSManagedObjectContext

    public init(container: NSPersistentContainer, context: NSManagedObjectContext) {
        self.container = container
        self.context = context
    }

    public func saveGame(game: SavedGame) -> Result<Void, Error> {
        let fetchRequest = NSFetchRequest<SavedGameCoreData>(entityName: savedGameEntityName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", game.id)
        fetchRequest.fetchLimit = 1

        do {
            let existingGame = try context.fetch(fetchRequest).first
            let savedGameEntity: SavedGameCoreData
            if let existingGame = existingGame {
                savedGameEntity = existingGame
            } else {
                savedGameEntity = SavedGameCoreData(context: context)
                savedGameEntity.id = Int64(game.id)
            }

            savedGameEntity.title = game.title
            savedGameEntity.releaseDate = game.released
            savedGameEntity.imageData = game.imageData

            try context.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    public func unsaveGame(gameId: Int) -> Result<Void, Error> {
        let fetchRequest = NSFetchRequest<SavedGameCoreData>(entityName: savedGameEntityName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", gameId)

        do {
            let results = try context.fetch(fetchRequest)
            if let gameToDelete = results.first {
                context.delete(gameToDelete)
                try context.save()
                return .success(())
            } else {
                return .failure(NSError(domain: "CoreDataError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Game with id \(gameId) not found"]))
            }
        } catch {
            return .failure(error)
        }
    }

    public func isGameSaved(gameId: Int) -> Bool {
        let fetchRequest = NSFetchRequest<SavedGameCoreData>(entityName: savedGameEntityName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", gameId)
        fetchRequest.fetchLimit = 1

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
    }

    public func fetchSavedGames() -> [SavedGame] {
        let fetchRequest = NSFetchRequest<SavedGameCoreData>(entityName: savedGameEntityName)

        do {
            let results = try context.fetch(fetchRequest)
            return results.map { entity -> SavedGame in
                return SavedGame(id: Int(entity.id),
                                title: entity.title ?? "",
                                imageUrl: nil,
                                released: entity.releaseDate ?? "",
                                imageData: entity.imageData)
            }
        } catch {
            return []
        }
    }
}
