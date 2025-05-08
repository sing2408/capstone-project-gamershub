//
//  FavouriteView.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import SwiftUI

struct SavedView: View {
    @StateObject var viewModel: SavedGamesViewModel
    let router = HomeRouter()
    @State private var selectedGame: Game?

    init() {
        _viewModel = StateObject(wrappedValue: SavedGamesViewModel(
            fetchSavedGamesUseCase: DependencyContainer.container.resolve(FetchSavedGamesUseCaseProtocol.self)!
        ))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.savedGames.isEmpty {
                    Text("No games saved yet.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    VStack(spacing: 8) {
                        ForEach(viewModel.savedGames) { savedGame in
                            let game = Game(
                                id: savedGame.id,
                                title: savedGame.title,
                                imageUrl: savedGame.imageUrl,
                                description: nil,
                                rating: nil,
                                released: savedGame.released,
                                genres: [],
                                tags: [],
                                imageData: savedGame.imageData 
                            )
                            NavigationLink(value: game.id) { 
                                GameRow(game: game)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(for: Int.self) { gameId in
                router.makeDetailView(for: gameId)
            }
            .navigationTitle("Saved Games")
            .onAppear {
                viewModel.loadSavedGames()
            }
        }
    }
}
