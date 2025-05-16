//
//  ProfileRepositoryProtocol.swift
//  Core
//
//  Created by Singgih Tulus Makmud on 09/05/25.
//

import Foundation

public protocol ProfileRepositoryProtocol {
    func getProfile() -> Result<Profile?, Error>
    func saveProfile(profile: Profile) -> Result<Void, Error>
}
