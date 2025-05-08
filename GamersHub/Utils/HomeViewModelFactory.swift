//
//  HomeViewModelFactory.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import Foundation
import Swinject

class HomeViewModelFactory {
    static func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(getGamesListUseCase: DependencyContainer.container.resolve(GetGamesListUseCaseProtocol.self)!)
    }
}
