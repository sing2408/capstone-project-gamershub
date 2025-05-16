//
//  GamesDataSource.swift
//  GamesFoundation
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Alamofire
import Combine
import Foundation
import CorePackage

public class GamesDataSource: GamesDataSourceProtocol {
    
    private let session: Session
    private let userAgent = "Gamershub iOS App"
    
    public init(session: Session) {
            self.session = session
    }
    
    public func getGames(page: Int,
                  searchQuery: String? = nil) -> AnyPublisher<(GamesListResponse, PaginationInfo), any Error> {
        var urlComponents = URLComponents(string: Endpoints.Games.list(page: page).url)
        var queryItems: [URLQueryItem] = urlComponents?.queryItems ?? []

        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: searchQuery))
        }

        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let headers: HTTPHeaders = ["User-Agent": userAgent]

        return session.request(url, headers: headers)
            .validate()
            .publishDecodable(type: GamesListResponse.self)
            .tryMap { response -> (GamesListResponse, PaginationInfo) in
                guard let httpResponse = response.response, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                guard let gameListResponse = response.value else {
                    throw URLError(.cannotParseResponse)
                }

                let paginationData = try JSONSerialization.jsonObject(with: response.data ?? Data()) as? [String: Any]

                let paginationInfo = PaginationInfo(
                    next: paginationData?["next"] as? String,
                    previous: paginationData?["previous"] as? String
                )
                return (gameListResponse, paginationInfo)
            }
            .eraseToAnyPublisher()
    }
    
    public func getGameDetails(id: Int) -> AnyPublisher<GameDetailResponse, Error> {
            let url = Endpoints.Games.detail(id: id).url
            let headers: HTTPHeaders = ["User-Agent": userAgent]

            return session.request(url, headers: headers)
                .validate()
                .publishDecodable(type: GameDetailResponse.self)
                .tryMap{ response -> GameDetailResponse in
                    
                    guard let httpResponse = response.response, (200...299).contains(httpResponse.statusCode) else {
                        throw URLError(.badServerResponse)
                    }
                    guard let gameDetailResponse = response.value else {
                        throw URLError(.cannotParseResponse)
                    }
                    return gameDetailResponse
                }
                .eraseToAnyPublisher()
        }
    
}
