//
//  DetailViewModel.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import CorePackage
import Foundation
import Combine
import SwiftUI

public class DetailViewModel: ObservableObject {
    private let getGameDetailUseCase: GetGameDetailsUseCaseProtocol
    private let saveGameUseCase: SaveGameUseCaseProtocol
    private let unsaveGameUseCase: UnsaveGameUseCaseProtocol
    private let isGameSavedUseCase: IsGameSavedUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []

    @Published var game: Game?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isCurrentlySaved: Bool = false

    public init(
        getGameDetailUseCase: GetGameDetailsUseCaseProtocol,
        saveGameUseCase: SaveGameUseCaseProtocol,
        unsaveGameUseCase: UnsaveGameUseCaseProtocol,
        isGameSavedUseCase: IsGameSavedUseCaseProtocol
    ) {
        self.getGameDetailUseCase = getGameDetailUseCase
        self.saveGameUseCase = saveGameUseCase
        self.unsaveGameUseCase = unsaveGameUseCase
        self.isGameSavedUseCase = isGameSavedUseCase
    }

    public func fetchGameDetails(id: Int) {
        isLoading = true
        getGameDetailUseCase.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.game = nil
                case .finished:
                    break
                }
            }, receiveValue: { fetchedGame in
                self.isLoading = false
                self.game = fetchedGame
                self.checkIfGameIsSaved(gameId: fetchedGame.id)
            })
            .store(in: &cancellables)
    }

    public func saveGameWithImage() {
        guard let game = self.game else {
            errorMessage = "No game details available to save."
            return
        }

        if let imageUrlString = game.imageUrl, let imageUrl = URL(string: imageUrlString) {
            isLoading = true
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                guard let self = self else { return }

                let imageData: Data? = data

                let savedGame = SavedGame(id: game.id,
                                         title: game.title,
                                         imageUrl: game.imageUrl,
                                         released: game.released,
                                         imageData: imageData)

                DispatchQueue.main.async {
                    self.isLoading = false
                    self.saveToRepository(savedGame: savedGame)
                }
            }.resume()
        } else {
            let savedGameWithoutImage = SavedGame(id: game.id, title: game.title, imageUrl: game.imageUrl, released: game.released, imageData: nil)
            self.saveToRepository(savedGame: savedGameWithoutImage)
        }
    }

    private func saveToRepository(savedGame: SavedGame) {
        let result = saveGameUseCase.execute(game: savedGame)
        switch result {
        case .success:
            isCurrentlySaved = true
        case .failure(let error):
            errorMessage = "Error saving game: \(error.localizedDescription)"
        }
    }

    public func unsaveGame(gameId: Int) {
        let result = unsaveGameUseCase.execute(gameId: gameId)
        switch result {
        case .success:
            isCurrentlySaved = false
        case .failure(let error):
            errorMessage = "Error unsaving game: \(error.localizedDescription)"
        }
    }

    public func checkIfGameIsSaved(gameId: Int) {
        isCurrentlySaved = isGameSavedUseCase.execute(gameId: gameId)
    }
}
