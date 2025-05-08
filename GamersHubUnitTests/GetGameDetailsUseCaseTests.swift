//
//  GetGameDetailsUseCaseTests.swift
//  GamersHubUnitTests
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import XCTest
import Combine
@testable import GamersHub

class GetGameDetailsUseCaseTests: XCTestCase {
    private var useCase: GetGameDetailsUseCase!
    private var mockRepository: MockGamesRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockGamesRepository()
        useCase = GetGameDetailsUseCase(repository: mockRepository)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetGameDetailsSuccess() {
        let expectedGame = Game(
            id: 1,
            title: "Game 1",
            imageUrl: nil,
            description: "Desc",
            rating: 4.5,
            released: "2023",
            genres: [],
            tags: []
        )
        mockRepository.gameDetailResult = .success(expectedGame)
        let expectation = XCTestExpectation(description: "Get game details success")

        useCase.execute(id: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    XCTFail("Expected success, but received failure: \(error)")
                }
            }, receiveValue: { game in
                XCTAssertEqual(game, expectedGame)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetGameDetailsFailure() {
        let expectedError = URLError(.badServerResponse)
        mockRepository.gameDetailResult = .failure(expectedError)
        let expectation = XCTestExpectation(description: "Get game details failure")

        useCase.execute(id: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but received success")
                case .failure(let error):
                    XCTAssertEqual(error as NSError, expectedError as NSError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
