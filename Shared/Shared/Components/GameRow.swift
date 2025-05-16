//
//  GameRow.swift
//  GamersHub
//
//  Created by Singgih Tulus Makmud on 15/04/25.
//

import SwiftUI
import CorePackage

public struct GameRow: View {
    let game: Game
    let systemImagePlaceholder: String = "dummy_image"
    
    public init(game: Game) {
        self.game = game
    }
    
    public var body: some View {
        HStack {
            
            if let imageData = game.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else if let imageUrl = game.imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                            .background(Color.gray.opacity(0.3))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemImagePlaceholder)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.3))
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemImagePlaceholder)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.3))
            }
            
            VStack(alignment: .leading) {
                Text(game.title)
                    .font(.headline)
                
                if let releaseDate = game.released {
                    Text("Release Date: \(releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
