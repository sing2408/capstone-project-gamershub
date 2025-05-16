//
//  PaginationInfo.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//
import Foundation

public struct PaginationInfo: Codable, Equatable {
    public let next: String?
    public let previous: String?
    public init(next: String?, previous: String?) {
        self.next = next
        self.previous = previous
    }
}
