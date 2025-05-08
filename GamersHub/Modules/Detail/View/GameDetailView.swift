//
//  GameDetailView.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 04/04/25.
//

import SwiftUI
import Combine

struct GameDetailView: View {
    @StateObject var viewModel: DetailViewModel
    @Environment(\.dismiss) var dismiss

    let gameId: Int

    init(gameId: Int, viewModel: DetailViewModel) {
            self.gameId = gameId
            _viewModel = StateObject(wrappedValue: viewModel)
        }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(viewModel.game?.title ?? "")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button {
                        if viewModel.isCurrentlySaved {
                            viewModel.unsaveGame(gameId: gameId)
                        } else {
                            viewModel.saveGameWithImage()
                        }
                    } label: {
                        Image(systemName: viewModel.isCurrentlySaved ? "bookmark.fill" : "bookmark")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }
                    .disabled(viewModel.isLoading)
                }
                AsyncImage(url: URL(string: viewModel.game?.imageUrl ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .background(Color.gray.opacity(0.3))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.3))
                    @unknown default:
                        EmptyView()
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Description:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(viewModel.game?.description ?? "No description available.")
                        .font(.body)
                }

                if let releaseDate = viewModel.game?.released {
                    VStack(alignment: .leading) {
                        Text("Release Date:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(releaseDate)
                            .font(.callout)
                    }
                }

                if let rating = viewModel.game?.rating {
                    HStack {
                        Text("Rating:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.2f", rating))
                            .font(.callout)
                    }
                }

                if let genres = viewModel.game?.genres, !genres.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Genres:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        HStack {
                            ForEach(genres) { genre in
                                Text(genre.name)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.2))
                                    .foregroundColor(.blue)
                                    .font(.caption)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Game Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if viewModel.isLoading {
                ProgressView()
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
        .onAppear {
            viewModel.fetchGameDetails(id: gameId)
            viewModel.checkIfGameIsSaved(gameId: gameId)
        }
    }
}
