//
//  SavedGamesViewModel.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 30/04/25.
//

import SwiftUI
import Combine
import CorePackage

public class SavedGamesViewModel: ObservableObject {
    private let fetchSavedGamesUseCase: FetchSavedGamesUseCaseProtocol
    @Published var savedGames: [SavedGame] = []

    public init(fetchSavedGamesUseCase: FetchSavedGamesUseCaseProtocol) {
        self.fetchSavedGamesUseCase = fetchSavedGamesUseCase
        loadSavedGames()
    }

    func loadSavedGames() {
        savedGames = fetchSavedGamesUseCase.execute()
    }
}
