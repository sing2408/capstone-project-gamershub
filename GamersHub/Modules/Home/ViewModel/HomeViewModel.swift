//
//  HomeViewModel.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    private let router = HomeRouter()
    private let getGamesListUseCase: GetGamesListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var games: [Game] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var selectedGame: Game?
    @Published var currentPage: Int = 1
    @Published var canLoadMore: Bool = true
    @Published var searchQuery: String = ""
    
    private var nextPageURL: String?
    
    init(getGamesListUseCase: GetGamesListUseCaseProtocol){
        self.getGamesListUseCase = getGamesListUseCase
    }
    
    func fetchGames(page: Int, searchQuery: String? = nil){
        guard canLoadMore, !isLoading else { return }
        isLoading = true
        getGamesListUseCase.execute(page: page, searchQuery: searchQuery)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.canLoadMore = false
                }
                
            }, receiveValue: { [weak self] (receivedGames, paginationInfo) in
                guard let self = self else { return }
                if page == 1 {
                    self.games = receivedGames
                } else {
                    self.games.append(contentsOf: receivedGames)
                }
                self.nextPageURL = paginationInfo.next
                self.canLoadMore = paginationInfo.next != nil
                if !receivedGames.isEmpty {
                    self.currentPage = page
                }
            })
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
            if canLoadMore && !isLoading {
                currentPage += 1
                fetchGames(page: currentPage, searchQuery: searchQuery)
            }
        }
    
    func search(query: String) {
            searchQuery = query
            currentPage = 1
            games.removeAll()
            canLoadMore = true 
            fetchGames(page: currentPage, searchQuery: searchQuery)
        }
    
}
