//
//  GetGameDetailsUseCase.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation
import Combine

public protocol GetGameDetailsUseCaseProtocol {
    func execute(id: Int) -> AnyPublisher<Game, Error>
}

public class GetGameDetailsUseCase: GetGameDetailsUseCaseProtocol {
    private let repository: GamesRepositoryProtocol

    public init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(id: Int) -> AnyPublisher<Game, Error> {
        return repository.getGameDetail(id: id)
    }
}
