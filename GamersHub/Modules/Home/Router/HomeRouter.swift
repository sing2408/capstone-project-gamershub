//
//  HomeRouter.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for gameId: Int) -> some View {
        let getGameDetailsUseCase = DependencyContainer.container.resolve(GetGameDetailsUseCaseProtocol.self)!
        let saveGameUseCase = DependencyContainer.container.resolve(SaveGameUseCaseProtocol.self)!
        let unsaveGameUseCase = DependencyContainer.container.resolve(UnsaveGameUseCaseProtocol.self)!
        let isGameSavedUseCase = DependencyContainer.container.resolve(IsGameSavedUseCaseProtocol.self)!
        
        let viewModel = DetailViewModel(
            getGameDetailUseCase: getGameDetailsUseCase,
            saveGameUseCase: saveGameUseCase,
            unsaveGameUseCase: unsaveGameUseCase,
            isGameSavedUseCase: isGameSavedUseCase
        )
        return GameDetailView(gameId: gameId, viewModel: viewModel)
    }
}
