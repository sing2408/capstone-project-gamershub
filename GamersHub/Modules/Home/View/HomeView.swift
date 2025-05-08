//
//  HomeView.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    let router = HomeRouter()
    
    var body: some View {
        NavigationStack {
            HStack {
                TextField("Search games", text: $viewModel.searchQuery)
                    .padding(8) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .onSubmit {
                        viewModel.search(query: viewModel.searchQuery)
                    }
                
                if !viewModel.searchQuery.isEmpty {
                    Button {
                        viewModel.searchQuery = ""
                        viewModel.search(query: "")
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing)
                }
            }
            .padding(.horizontal)
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                }
                VStack(spacing: 8) {
                    ForEach(viewModel.games, id: \.id) { game in
                        GameRow(game: game)
                            .onTapGesture {
                                viewModel.selectedGame = game
                            }
                    }
                }
                .padding()
                
                if viewModel.canLoadMore {
                    Button("Load More") {
                        viewModel.loadNextPage()
                    }
                    .padding(.bottom)
                } else if !viewModel.games.isEmpty && viewModel.errorMessage == nil {
                    Text("No more games to load.")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .navigationDestination(item: $viewModel.selectedGame) { game in
                router.makeDetailView(for: game.id)
            }
            .navigationTitle("Games")
            .onAppear {
                viewModel.fetchGames(page: 1)
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }
}
