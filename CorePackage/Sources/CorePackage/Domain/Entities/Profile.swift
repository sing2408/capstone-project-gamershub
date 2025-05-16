//
//  Profile.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public struct Profile {
    public let name: String
    public let imageData: Data?

    public init(name: String, imageData: Data?) {
        self.name = name
        self.imageData = imageData
    }
}
