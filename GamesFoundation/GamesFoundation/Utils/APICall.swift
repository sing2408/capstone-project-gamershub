//
//  APICall.swift
//  GamesFoundation
//
//  Created by Singgih Tulus Makmud on 10/05/25.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/"
    static let apiKey = "8941b82071fe4b70a82e07168a3b5c25"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Games: Endpoint {
        case list(page: Int)
        case detail(id: Int)
        
        public var url: String {
            switch self {
            case .list(page: let page):
                return "\(API.baseUrl)games?key=\(API.apiKey)&page=\(page)"
            case .detail(id: let id):
                return "\(API.baseUrl)games/\(id)?key=\(API.apiKey)"
            }
        }
        
    }
}
