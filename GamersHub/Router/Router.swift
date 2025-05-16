//
//  HomeRouter.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import SwiftUI
import CorePackage
import About
import Shared
import Saved
import Home
import Detail

class Router: RoutingProtocol {
    
    typealias DetailViewType = GameDetailView
    typealias SavedViewType = SavedView
    typealias AboutViewType = AboutView
    typealias HomeViewType = HomeView
    
    func makeHomeView() -> HomeView<Router> {
        let getGamesListUseCase = DependencyContainer.container.resolve(GetGamesListUseCaseProtocol.self)!
        let homeViewModel = HomeViewModel(getGamesListUseCase: getGamesListUseCase)
        return HomeView(viewModel: homeViewModel, router: self)
    }
    
    func makeDetailView(for gameId: Int) -> GameDetailView {
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
    
    func makeSavedView() -> SavedView<Router> {
        let fetchSavedGamesUseCase = DependencyContainer.container.resolve(FetchSavedGamesUseCaseProtocol.self)!
        let savedGamesViewModel = SavedGamesViewModel(fetchSavedGamesUseCase: fetchSavedGamesUseCase)
        return SavedView(viewModel: savedGamesViewModel, router: self)
    }
    
    func makeAboutView() -> AboutView {
        let profileUseCase = DependencyContainer.container.resolve(ProfileUseCaseProtocol.self)!
        let aboutViewModel = AboutViewModel(profileUseCase: profileUseCase)
        return AboutView(viewModel: aboutViewModel)
    }
}
