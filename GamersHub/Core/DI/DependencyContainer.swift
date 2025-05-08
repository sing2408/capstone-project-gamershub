//
//  DependencyContainer.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import Foundation
import Swinject
import Alamofire
import CoreData

class DependencyContainer {
    static let container: Container = {
        let container = Container()
        
        container.register(Session.self) { _ in
            Session.default
        }.inObjectScope(.container)
        
        container.register(GamesDataSourceProtocol.self) { resolver in
            GamesDataSource(session: resolver.resolve(Session.self)!)
        }.inObjectScope(.container)
        
        container.register(GamesRepositoryProtocol.self) { resolver in
            GamesRepository(dataSource: resolver.resolve(GamesDataSourceProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(GetGamesListUseCaseProtocol.self) { resolver in
            GetGamesListUseCase(repository: resolver.resolve(GamesRepositoryProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(GetGameDetailsUseCaseProtocol.self) { resolver in
            GetGameDetailsUseCase(repository: resolver.resolve(GamesRepositoryProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(NSPersistentContainer.self) { _ in
            CoreDataSetup.shared.persistenceController.container
        }.inObjectScope(.container)
        
        container.register(NSManagedObjectContext.self) { resolver in
            let container = resolver.resolve(NSPersistentContainer.self)!
            return container.viewContext
        }.inObjectScope(.container)
        
        container.register(SavedGamesRepositoryProtocol.self) { resolver in
            let context = resolver.resolve(NSManagedObjectContext.self)!
            let persistentContainer = resolver.resolve(NSPersistentContainer.self)!
            return SavedGamesRepository(container: persistentContainer, context: context)
        }.inObjectScope(.container)
        
        container.register(FetchSavedGamesUseCaseProtocol.self) { resolver in
            FetchSavedGamesUseCase(repository: resolver.resolve(SavedGamesRepositoryProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(SaveGameUseCaseProtocol.self) { resolver in
            SaveGameUseCase(repository: resolver.resolve(SavedGamesRepositoryProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(UnsaveGameUseCaseProtocol.self) { resolver in
            UnsaveGameUseCase(repository: resolver.resolve(SavedGamesRepositoryProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(IsGameSavedUseCaseProtocol.self) { resolver in
            IsGameSavedUseCase(repository: resolver.resolve(SavedGamesRepositoryProtocol.self)!)
        }.inObjectScope(.container)
        
        container.register(ProfileRepositoryProtocol.self) { resolver in
            ProfileRepository(context: resolver.resolve(NSManagedObjectContext.self)!)
        }.inObjectScope(.container)

        container.register(ProfileUseCaseProtocol.self) { resolver in
            ProfileUseCase(profileRepository: resolver.resolve(ProfileRepositoryProtocol.self)!)
        }.inObjectScope(.container)
        return container
    }()
}
