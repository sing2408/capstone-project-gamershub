//
//  GetGamesListUseCaseTests.swift
//  GamersHubUnitTests
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import XCTest
import Combine
@testable import GamersHub

class GetGamesListUseCaseTests: XCTestCase {
    private var useCase: GetGamesListUseCase!
    private var mockRepository: MockGamesRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockGamesRepository()
        useCase = GetGamesListUseCase(repository: mockRepository)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    func testGetGamesListSuccess() {
        let expectedGames = [Game(id: 1,
                                  title: "Game 1",
                                  imageUrl: nil,
                                  description: nil,
                                  rating: nil,
                                  released: nil,
                                  genres: [],
                                  tags: [])]
        let expectedPaginationInfo = PaginationInfo(next: nil, previous: nil)
        mockRepository.gamesResult = .success((expectedGames, expectedPaginationInfo))
        mockRepository.searchResult = .success(([], PaginationInfo(next: nil, previous: nil)))

        let expectation = XCTestExpectation(description: "Get games list success")

        useCase.execute(page: 1, searchQuery: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected success, but received failure: \(error)")
                }
            }, receiveValue: { (games, paginationInfo) in
                XCTAssertEqual(games, expectedGames)
                XCTAssertEqual(paginationInfo, expectedPaginationInfo)
                XCTAssertFalse(self.mockRepository.searchCalled)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetGamesListWithSearch() {
        let expectedSearchGames = [Game(id: 2,
                                        title: "Search Game 1",
                                        imageUrl: nil,
                                        description: nil,
                                        rating: nil,
                                        released: nil,
                                        genres: [],
                                        tags: [])]
        let expectedSearchPaginationInfo = PaginationInfo(next: nil, previous: nil)
        mockRepository.searchResult = .success((expectedSearchGames,
                                                expectedSearchPaginationInfo))

        let expectation = XCTestExpectation(description: "Get games list with search success")

        useCase.execute(page: 1, searchQuery: "search")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected success, but received failure: \(error)")
                }
            }, receiveValue: { (games, paginationInfo) in
                XCTAssertEqual(games, expectedSearchGames)
                XCTAssertEqual(paginationInfo, expectedSearchPaginationInfo)
                XCTAssertTrue(self.mockRepository.searchCalled)
                XCTAssertEqual(self.mockRepository.searchQuery, "search")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetGamesListFailure() {
        let expectedError = URLError(.badServerResponse)
        mockRepository.gamesResult = .failure(expectedError)

        let expectation = XCTestExpectation(description: "Get games list failure")

        useCase.execute(page: 1, searchQuery: nil)
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

    func testGetGamesListEmpty() {
        let expectedGames: [Game] = []
        let expectedPaginationInfo = PaginationInfo(next: nil, previous: nil)
        mockRepository.gamesResult = .success((expectedGames, expectedPaginationInfo))
        mockRepository.searchResult = .success(([], PaginationInfo(next: nil, previous: nil)))
        let expectation = XCTestExpectation(description: "Get games list empty")

        useCase.execute(page: 1, searchQuery: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): XCTFail("Expected success, but received failure: \(error)")
                }
            }, receiveValue: { (games, paginationInfo) in
                XCTAssertTrue(games.isEmpty)
                XCTAssertEqual(paginationInfo, expectedPaginationInfo)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
